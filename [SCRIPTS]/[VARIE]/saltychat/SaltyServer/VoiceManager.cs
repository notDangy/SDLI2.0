using System;
using System.Collections.Generic;
using System.Linq;
using SaltyShared;
using CitizenFX.Core;
using CitizenFX.Core.Native;

namespace SaltyServer
{
    public class VoiceManager : BaseScript
    {
        #region Properties / Fields
        public static VoiceManager Instance { get; private set; }

        public bool Enabled { get; private set; }
        public string MinimumPluginVersion { get; private set; }

        public Vector3[] RadioTowers { get; private set; } = new Vector3[0];

        public VoiceClient[] VoiceClients => this._voiceClients.Values.ToArray();
        private Dictionary<Player, VoiceClient> _voiceClients = new Dictionary<Player, VoiceClient>();

        public RadioChannel[] RadioChannels => this._radioChannels.ToArray();
        private List<RadioChannel> _radioChannels = new List<RadioChannel>();
        #endregion

        #region CTOR
        public VoiceManager()
        {
            VoiceManager.Instance = this;

            // Phone Exports
            this.Exports.Add("EstablishCall", new Action<int, int>(this.EstablishCall));
            this.Exports.Add("EndCall", new Action<int, int>(this.EndCall));

            // Radio Exports
            this.Exports.Add("SetPlayerRadioSpeaker", new Action<int, bool>(this.SetPlayerRadioSpeaker));
            this.Exports.Add("SetPlayerRadioChannel", new Action<int, string, bool>(this.SetPlayerRadioChannel));
            this.Exports.Add("RemovePlayerRadioChannel", new Action<int, string>(this.RemovePlayerRadioChannel));
            this.Exports.Add("SetRadioTowers", new Action<dynamic>(this.SetRadioTowers));
        }
        #endregion

        #region Server Events
        [EventHandler("onResourceStart")]
        private void OnResourceStart(string resourceName)
        {
            if (resourceName != API.GetCurrentResourceName())
                return;

            this.Enabled = API.GetResourceMetadata(resourceName, "VoiceEnabled", 0).Equals("true", StringComparison.OrdinalIgnoreCase);

            if (this.Enabled)
            {
                this.MinimumPluginVersion = API.GetResourceMetadata(resourceName, "MinimumPluginVersion", 0);
            }
        }

        [EventHandler("onResourceStop")]
        private void OnResourceStop(string resourceName)
        {
            if (resourceName != API.GetCurrentResourceName())
                return;

            this.Enabled = false;

            lock (this._voiceClients)
            {
                this._voiceClients.Clear();
            }

            lock (this._radioChannels)
            {
                foreach (RadioChannel radioChannel in this._radioChannels)
                {
                    foreach (RadioChannelMember member in radioChannel.Members)
                    {
                        radioChannel.RemoveMember(member.VoiceClient);
                    }
                }

                this._radioChannels.Clear();
            }
        }

        [EventHandler("playerDropped")]
        private void OnPlayerDisconnected([FromSource] Player player, string reason)
        {
            if (!this._voiceClients.TryGetValue(player, out VoiceClient client))
                return;

            foreach (RadioChannel radioChannel in this.RadioChannels.Where(c => c.IsMember(client)))
            {
                radioChannel.RemoveMember(client);
            }

            lock (this._voiceClients)
            {
                this._voiceClients.Remove(player);
            }

            BaseScript.TriggerClientEvent(Event.SaltyChat_RemoveClient, player.Handle);
        }
        #endregion

        #region RemoteEvents (Proximity)

        [EventHandler(Event.SaltyChat_SetVoiceRange)]
        private void OnSetVoiceRange([FromSource] Player player, float voiceRange)
        {
            if (!this._voiceClients.TryGetValue(player, out VoiceClient client))
                return;

            if (Array.IndexOf(SharedData.VoiceRanges, voiceRange) >= 0)
            {
                client.VoiceRange = voiceRange;

                BaseScript.TriggerClientEvent(Event.SaltyChat_UpdateClient, player.Handle, client.TeamSpeakName, client.VoiceRange);
            }
        }
        #endregion

        #region Exports (Phone)
        private void EstablishCall(int callerNetId, int partnerNetId)
        {
            Player caller = this.Players[callerNetId];
            Player callPartner = this.Players[partnerNetId];

            caller.TriggerEvent(Event.SaltyChat_EstablishCall, callPartner.Handle);
            callPartner.TriggerEvent(Event.SaltyChat_EstablishCall, caller.Handle);
        }

        private void EndCall(int callerNetId, int partnerNetId)
        {
            Player caller = this.Players[callerNetId];
            Player callPartner = this.Players[partnerNetId];

            caller.TriggerEvent(Event.SaltyChat_EndCall, callPartner.Handle);
            callPartner.TriggerEvent(Event.SaltyChat_EndCall, caller.Handle);
        }
        #endregion

        #region Exports (Radio)
        private void SetPlayerRadioSpeaker(int netId, bool toggle)
        {
            Player player = this.Players[netId];

            this.SetRadioSpeaker(player, toggle);
        }

        private void SetPlayerRadioChannel(int netId, string radioChannelName, bool isPrimary)
        {
            Player player = this.Players[netId];

            this.JoinRadioChannel(player, radioChannelName, isPrimary);
        }

        private void RemovePlayerRadioChannel(int netId, string radioChannelName)
        {
            Player player = this.Players[netId];

            this.LeaveRadioChannel(player, radioChannelName);
        }

        private void SetRadioTowers(dynamic towers)
        {
            List<Vector3> towerPositions = new List<Vector3>();

            foreach (dynamic tower in towers)
            {
                towerPositions.Add(new Vector3(tower[0], tower[1], tower[2]));
            }

            this.RadioTowers = towerPositions.ToArray();

            BaseScript.TriggerClientEvent(Event.SaltyChat_UpdateRadioTowers, this.RadioTowers);
        }
        #endregion

        #region Remote Events (Salty Chat)
        [EventHandler(Event.SaltyChat_Initialize)]
        private void OnInitialize([FromSource] Player player)
        {
            if (!this.Enabled)
                return;

            VoiceClient voiceClient;

            lock (this._voiceClients)
            {
                voiceClient = new VoiceClient(player, this.GetTeamSpeakName(), SharedData.VoiceRanges[1]);
                this._voiceClients.Add(player, voiceClient);
            }

            player.TriggerEvent(Event.SaltyChat_Initialize, voiceClient.TeamSpeakName, this.RadioTowers);

            foreach (VoiceClient client in this._voiceClients.Values.ToArray().Where(c => c.Player != player))
            {
                player.TriggerEvent(Event.SaltyChat_UpdateClient, client.Player.Handle, client.TeamSpeakName, client.VoiceRange);

                client.Player.TriggerEvent(Event.SaltyChat_UpdateClient, player.Handle, voiceClient.TeamSpeakName, voiceClient.VoiceRange);
            }
        }

        [EventHandler(Event.SaltyChat_CheckVersion)]
        private void OnCheckVersion([FromSource] Player player, string version)
        {
            if (!this._voiceClients.TryGetValue(player, out VoiceClient client))
                return;

            if (!this.IsVersionAccepted(version))
            {
                player.Drop($"[Salty Chat] Required Version: {this.MinimumPluginVersion}");
                return;
            }
        }
        #endregion

        #region Commands (Radio)
#if DEBUG
        [Command("speaker")]
        private void OnSetRadioSpeaker(Player player, string[] args)
        {
            if (args.Length < 1)
            {
                player.SendChatMessage("Usage", "/speaker {true/false}");
                return;
            }

            bool toggle = String.Equals(args[0], "true", StringComparison.OrdinalIgnoreCase);

            this.SetRadioSpeaker(player, toggle);

            player.SendChatMessage("Speaker", $"The speaker is now {(toggle ? "on" : "off")}.");
        }

        [Command("joinradio")]
        private void OnJoinRadioChannel(Player player, string[] args)
        {
            if (args.Length < 1)
            {
                player.SendChatMessage("Usage", "/joinradio {radioChannelName}");
                return;
            }

            this.JoinRadioChannel(player, args[0], true);

            player.SendChatMessage("Radio", $"You joined channel \"{args[0]}\".");
        }

        [Command("joinsecradio")]
        private void OnJoinSecondaryRadioChannel(Player player, string[] args)
        {
            if (args.Length < 1)
            {
                player.SendChatMessage("Usage", "/joinsecradio {radioChannelName}");
                return;
            }

            this.JoinRadioChannel(player, args[0], false);

            player.SendChatMessage("Radio", $"You joined secondary channel \"{args[0]}\".");
        }

        [Command("leaveradio")]
        private void OnLeaveRadioChannel(Player player, string[] args)
        {
            if (args.Length < 1)
            {
                player.SendChatMessage("Usage", "/leaveradio {radioChannelName}");
                return;
            }

            this.LeaveRadioChannel(player, args[0]);

            player.SendChatMessage("Radio", $"You left channel \"{args[0]}\".");
        }
#endif
        #endregion

        #region Remote Events (Radio)
        [EventHandler(Event.SaltyChat_IsSending)]
        private void OnSendingOnRadio([FromSource] Player player, string radioChannelName, bool isSending)
        {
            if (!this._voiceClients.TryGetValue(player, out VoiceClient voiceClient))
                return;

            RadioChannel radioChannel = this.GetRadioChannel(radioChannelName, false);

            if (radioChannel == null || !radioChannel.IsMember(voiceClient))
                return;

            radioChannel.Send(voiceClient, isSending);
        }
        #endregion

        #region Methods (Radio)
        public RadioChannel GetRadioChannel(string name, bool create)
        {
            RadioChannel radioChannel;

            lock (this._radioChannels)
            {
                radioChannel = this.RadioChannels.FirstOrDefault(r => r.Name == name);

                if (radioChannel == null && create)
                {
                    radioChannel = new RadioChannel(name);

                    this._radioChannels.Add(radioChannel);
                }
            }

            return radioChannel;
        }

        public void SetRadioSpeaker(Player player, bool toggle)
        {
            if (!this._voiceClients.TryGetValue(player, out VoiceClient voiceClient))
                return;

            voiceClient.RadioSpeaker = toggle;
        }

        public void JoinRadioChannel(Player player, string radioChannelName, bool isPrimary)
        {
            if (!this._voiceClients.TryGetValue(player, out VoiceClient voiceClient))
                return;

            foreach (RadioChannel channel in this.RadioChannels)
            {
                if (channel.Members.Any(v => v.VoiceClient == voiceClient && v.IsPrimary == isPrimary))
                    return;
            }

            RadioChannel radioChannel = this.GetRadioChannel(radioChannelName, true);

            radioChannel.AddMember(voiceClient, isPrimary);
        }

        public void LeaveRadioChannel(Player player, string radioChannelName)
        {
            if (!this._voiceClients.TryGetValue(player, out VoiceClient voiceClient))
                return;

            RadioChannel radioChannel = this.GetRadioChannel(radioChannelName, false);

            if (radioChannel != null)
            {
                radioChannel.RemoveMember(voiceClient);

                if (radioChannel.Members.Length == 0)
                {
                    this._radioChannels.Remove(radioChannel);
                }
            }
        }

        public void SendingOnRadio(Player player, bool isSending)
        {
            if (!this._voiceClients.TryGetValue(player, out VoiceClient voiceClient))
                return;

            foreach (RadioChannel radioChannel in this.RadioChannels)
            {
                if (radioChannel.IsMember(voiceClient))
                {
                    radioChannel.Send(voiceClient, isSending);

                    return;
                }
            }
        }
        #endregion

        #region Methods (Misc)
        public string GetTeamSpeakName()
        {
            string name;

            do
            {
                name = Guid.NewGuid().ToString().Replace("-", "");

                if (name.Length > 30)
                {
                    name = name.Remove(29, name.Length - 30);
                }
            }
            while (this._voiceClients.Values.Any(c => c.TeamSpeakName == name));

            return name;
        }

        public bool IsVersionAccepted(string version)
        {
            if (!String.IsNullOrWhiteSpace(this.MinimumPluginVersion))
            {
                try
                {
                    string[] minimumVersionArray = this.MinimumPluginVersion.Split('.');
                    string[] versionArray = version.Split('.');

                    int lengthCounter = 0;

                    if (versionArray.Length >= minimumVersionArray.Length)
                    {
                        lengthCounter = minimumVersionArray.Length;
                    }
                    else
                    {
                        lengthCounter = versionArray.Length;
                    }

                    for (int i = 0; i < lengthCounter; i++)
                    {
                        int min = Convert.ToInt32(minimumVersionArray[i]);
                        int cur = Convert.ToInt32(versionArray[i]);

                        if (cur > min)
                        {
                            return true;
                        }
                        else if (min > cur)
                        {
                            return false;
                        }
                    }
                }
                catch
                {
                    return false;
                }
            }

            return true;
        }
        #endregion
    }
}
