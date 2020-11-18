using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CitizenFX.Core;
using CitizenFX.Core.Native;
using RedM.External;
using SaltyShared;

namespace SaltyClient
{
    internal class VoiceManager : BaseScript
    {
        #region Properties / Fields
        public bool IsEnabled { get; private set; }
        public bool IsConnected { get; private set; }
        public bool IsIngame { get; private set; }
        public bool IsNuiReady { get; private set; }

        public string TeamSpeakName { get; private set; }
        public string ServerUniqueIdentifier { get; private set; }
        public string SoundPack { get; private set; }
        public ulong IngameChannel { get; private set; }
        public string IngameChannelPassword { get; private set; }
        public ulong[] SwissChannelIds { get; private set; } = new ulong[0];

        public VoiceClient[] VoiceClients => this._voiceClients.Values.ToArray();
        private Dictionary<int, VoiceClient> _voiceClients = new Dictionary<int, VoiceClient>();

        public Vector3[] RadioTowers { get; private set; }

        public string WebSocketAddress { get; private set; } = "lh.saltmine.de:38088";
        public float VoiceRange { get; private set; } = SharedData.VoiceRanges[1];
        public string PrimaryRadioChannel { get; private set; }
        public string SecondaryRadioChannel { get; private set; }

        public PlayerList PlayerList { get; } = new PlayerList();

        public bool IsTalking { get; private set; }
        public bool IsMicrophoneMuted { get; private set; }
        public bool IsMicrophoneEnabled { get; private set; }
        public bool IsSoundMuted { get; private set; }
        public bool IsSoundEnabled { get; private set; }
        #endregion

        #region CTOR
        public VoiceManager()
        {
            API.RegisterNuiCallbackType(NuiEvent.SaltyChat_OnConnected);
            API.RegisterNuiCallbackType(NuiEvent.SaltyChat_OnDisconnected);
            API.RegisterNuiCallbackType(NuiEvent.SaltyChat_OnError);
            API.RegisterNuiCallbackType(NuiEvent.SaltyChat_OnMessage);
            API.RegisterNuiCallbackType(NuiEvent.SaltyChat_OnNuiReady);
        }
        #endregion

        #region Events
        [EventHandler("onClientResourceStop")]
        private void OnResourceStop(string resourceName)
        {
            if (resourceName != API.GetCurrentResourceName())
                return;

            this.IsEnabled = false;
            this.IsConnected = false;

            lock (this._voiceClients)
            {
                this._voiceClients.Clear();
            }

            this.PrimaryRadioChannel = null;
        }
        #endregion

        #region Remote Events (Handling)
        [EventHandler(Event.SaltyChat_Initialize)]
        private void OnInitialize(string teamSpeakName, dynamic towers)
        {
            this.TeamSpeakName = teamSpeakName;

            List<Vector3> towerPositions = new List<Vector3>();

            foreach (dynamic tower in towers)
            {
                towerPositions.Add(new Vector3(tower[0], tower[1], tower[2]));
            }

            this.RadioTowers = towerPositions.ToArray();

            this.IsEnabled = true;

            if (this.IsConnected)
                this.InitializePlugin();
            else if (this.IsNuiReady)
                this.ExecuteCommand("connect", this.WebSocketAddress);
            else
                Debug.WriteLine("[Salty Chat] Got server response, but NUI wasn't ready");

            //VoiceManager.DisplayDebug(true);
        }

        [EventHandler(Event.SaltyChat_UpdateClient)]
        private void OnClientUpdate(string handle, string teamSpeakName, float voiceRange)
        {
            if (!Int32.TryParse(handle, out int serverId))
                return;

            if (Game.Player.ServerId == serverId)
                return;

            lock (this._voiceClients)
            {
                if (this._voiceClients.TryGetValue(serverId, out VoiceClient client))
                {
                    client.TeamSpeakName = teamSpeakName;
                    client.VoiceRange = voiceRange;
                }
                else
                {
                    this._voiceClients.Add(serverId, new VoiceClient(serverId, this.PlayerList[serverId], teamSpeakName, voiceRange));
                }
            }
        }

        [EventHandler(Event.SaltyChat_RemoveClient)]
        private void OnClientRemove(string handle)
        {
            if (!Int32.TryParse(handle, out int serverId))
                return;

            lock (this._voiceClients)
            {
                if (this._voiceClients.TryGetValue(serverId, out VoiceClient client))
                {
                    this.ExecuteCommand(new PluginCommand(Command.RemovePlayer, this.ServerUniqueIdentifier, new PlayerState(client.TeamSpeakName)));

                    this._voiceClients.Remove(serverId);
                }
            }
        }
        #endregion

        #region Remote Events (Phone)
        [EventHandler(Event.SaltyChat_EstablishCall)]
        private void OnEstablishCall(string handle)
        {
            if (!Int32.TryParse(handle, out int serverId))
                return;

            if (this._voiceClients.TryGetValue(serverId, out VoiceClient client))
            {
                //Vector3 playerPosition = Game.PlayerPed.Position;
                //Vector3 remotePlayerPosition = client.Player.Character.Position;

                // ToDo: Find alternative - Natives not available in RDR3
                //int signalDistortion = API.GetZoneScumminess(API.GetZoneAtCoords(playerPosition.X, playerPosition.Y, playerPosition.Z));
                //signalDistortion += API.GetZoneScumminess(API.GetZoneAtCoords(remotePlayerPosition.X, remotePlayerPosition.Y, remotePlayerPosition.Z));
                
                int signalDistortion = 0;

                this.ExecuteCommand(
                    new PluginCommand(
                        Command.PhoneCommunicationUpdate,
                        this.ServerUniqueIdentifier,
                        new PhoneCommunication(
                            client.TeamSpeakName,
                            signalDistortion
                        )
                    )
                );
            }
        }

        [EventHandler(Event.SaltyChat_EndCall)]
        private void OnEndCall(string handle)
        {
            if (!Int32.TryParse(handle, out int serverId))
                return;

            if (this._voiceClients.TryGetValue(serverId, out VoiceClient client))
            {
                this.ExecuteCommand(
                    new PluginCommand(
                        Command.StopPhoneCommunication,
                        this.ServerUniqueIdentifier,
                        new PhoneCommunication(
                            client.TeamSpeakName
                        )
                    )
                );
            }
        }
        #endregion

        #region Remote Events (Radio)
        [EventHandler(Event.SaltyChat_SetRadioChannel)]
        private void OnSetRadioChannel(string radioChannel, bool isPrimary)
        {
            if (isPrimary)
            {
                this.PrimaryRadioChannel = radioChannel;

                if (String.IsNullOrEmpty(radioChannel))
                    this.PlaySound("leaveRadioChannel", false, "radio");
                else
                    this.PlaySound("enterRadioChannel", false, "radio");
            }
            else
            {
                this.SecondaryRadioChannel = radioChannel;

                if (String.IsNullOrEmpty(radioChannel))
                    this.PlaySound("leaveRadioChannel", false, "radio");
                else
                    this.PlaySound("enterRadioChannel", false, "radio");
            }
        }

        [EventHandler(Event.SaltyChat_IsSending)]
        private void OnPlayerIsSending(string handle, string radioChannel, bool isSending, bool stateChange)
        {
            this.OnPlayerIsSendingRelayed(handle, radioChannel, isSending, stateChange, true, new List<dynamic>());
        }

        [EventHandler(Event.SaltyChat_IsSendingRelayed)]
        private void OnPlayerIsSendingRelayed(string handle, string radioChannel, bool isSending, bool stateChange, bool direct, List<dynamic> relays)
        {
            if (!Int32.TryParse(handle, out int serverId))
                return;

            if (serverId == Game.Player.ServerId)
            {
                this.PlaySound("selfMicClick", false, "MicClick");
            }
            else if (this._voiceClients.TryGetValue(serverId, out VoiceClient client))
            {
                if (isSending)
                {
                    this.ExecuteCommand(
                        new PluginCommand(
                            Command.RadioCommunicationUpdate,
                            this.ServerUniqueIdentifier,
                            new RadioCommunication(
                                client.TeamSpeakName,
                                RadioType.LongRange,
                                RadioType.LongRange,
                                stateChange,
                                direct,
                                this.SecondaryRadioChannel == radioChannel,
                                relays.Select(r => (string)r).ToArray()
                            )
                        )
                    );
                }
                else
                {
                    this.ExecuteCommand(
                        new PluginCommand(
                            Command.RadioCommunicationUpdate,
                            this.ServerUniqueIdentifier,
                            new RadioCommunication(
                                client.TeamSpeakName,
                                RadioType.None,
                                RadioType.None,
                                stateChange,
                                this.SecondaryRadioChannel == radioChannel
                            )
                        )
                    );
                }
            }
        }

        [EventHandler(Event.SaltyChat_UpdateRadioTowers)]
        private void OnUpdateRadioTowers(dynamic towers)
        {
            List<Vector3> towerPositions = new List<Vector3>();

            foreach (dynamic tower in towers)
            {
                towerPositions.Add(new Vector3(tower[0], tower[1], tower[2]));
            }

            this.RadioTowers = towerPositions.ToArray();

            this.ExecuteCommand(
                new PluginCommand(
                    Command.RadioTowerUpdate,
                    this.ServerUniqueIdentifier,
                    new RadioTower(
                        towerPositions.ToArray()
                    )
                )
            );
        }
        #endregion

        #region NUI Events
        [EventHandler("__cfx_nui:" + NuiEvent.SaltyChat_OnNuiReady)]
        private void OnNuiReady(dynamic dummy, dynamic cb)
        {
            this.IsNuiReady = true;

            if (this.IsEnabled && this.TeamSpeakName != null && !this.IsConnected)
            {
                Debug.WriteLine("[Salty Chat] NUI is now ready, connecting...");

                this.ExecuteCommand("connect", this.WebSocketAddress);
            }

            cb("");
        }

        [EventHandler("__cfx_nui:" + NuiEvent.SaltyChat_OnConnected)]
        private void OnConnected(dynamic dummy, dynamic cb)
        {
            this.IsConnected = true;

            if (this.IsEnabled)
                this.InitializePlugin();

            cb("");
        }

        [EventHandler("__cfx_nui:" + NuiEvent.SaltyChat_OnDisconnected)]
        private void OnDisconnected(dynamic dummy, dynamic cb)
        {
            this.IsConnected = false;

            cb("");
        }

        [EventHandler("__cfx_nui:" + NuiEvent.SaltyChat_OnMessage)]
        private void OnMessage(dynamic message, dynamic cb)
        {
            cb("");

            PluginCommand pluginCommand = PluginCommand.Deserialize(message);

            if (pluginCommand.ServerUniqueIdentifier != this.ServerUniqueIdentifier)
                return;

            switch (pluginCommand.Command)
            {
                case Command.PluginState:
                    {
                        if (pluginCommand.TryGetPayload(out PluginState pluginState))
                        {
                            BaseScript.TriggerServerEvent(Event.SaltyChat_CheckVersion, pluginState.Version);

                            this.ExecuteCommand(
                                new PluginCommand(
                                    Command.RadioTowerUpdate,
                                    this.ServerUniqueIdentifier,
                                    new RadioTower(this.RadioTowers)
                                )
                            );
                        }

                        break;
                    }
                case Command.Reset:
                    {
                        this.IsIngame = false;

                        this.InitializePlugin();

                        break;
                    }
                case Command.Ping:
                    {
                        this.ExecuteCommand(new PluginCommand(this.ServerUniqueIdentifier));

                        break;
                    }
                case Command.InstanceState:
                    {
                        if (pluginCommand.TryGetPayload(out InstanceState instanceState))
                        {
                            this.IsIngame = instanceState.IsReady;
                        }

                        break;
                    }
                case Command.SoundState:
                    {
                        if (pluginCommand.TryGetPayload(out SoundState soundState))
                        {
                            if (soundState.IsMicrophoneMuted != this.IsMicrophoneMuted)
                            {
                                this.IsMicrophoneMuted = soundState.IsMicrophoneMuted;

                                BaseScript.TriggerEvent(Event.SaltyChat_MicStateChanged, this.IsMicrophoneMuted);
                            }

                            if (soundState.IsMicrophoneEnabled != this.IsMicrophoneEnabled)
                            {
                                this.IsMicrophoneEnabled = soundState.IsMicrophoneEnabled;

                                BaseScript.TriggerEvent(Event.SaltyChat_MicEnabledChanged, this.IsMicrophoneEnabled);
                            }

                            if (soundState.IsSoundMuted != this.IsSoundMuted)
                            {
                                this.IsSoundMuted = soundState.IsSoundMuted;

                                BaseScript.TriggerEvent(Event.SaltyChat_SoundStateChanged, this.IsSoundMuted);
                            }

                            if (soundState.IsSoundEnabled != this.IsSoundEnabled)
                            {
                                this.IsSoundEnabled = soundState.IsSoundEnabled;

                                BaseScript.TriggerEvent(Event.SaltyChat_SoundEnabledChanged, this.IsSoundEnabled);
                            }
                        }

                        break;
                    }
                case Command.TalkState:
                    {
                        if (pluginCommand.TryGetPayload(out TalkState talkState))
                            this.SetPlayerTalking(talkState.Name, talkState.IsTalking);

                        break;
                    }
            }
        }

        [EventHandler("__cfx_nui:" + NuiEvent.SaltyChat_OnError)]
        private void OnError(dynamic message, dynamic cb)
        {
            try
            {
                PluginError pluginError = PluginError.Deserialize(message);

                switch (pluginError.Error)
                {
                    case Error.AlreadyInGame:
                        {
                            Debug.WriteLine($"[Salty Chat] Error: Seems like we are already in an instance, retry...");

                            this.InitializePlugin();

                            break;
                        }
                    default:
                        {
                            Debug.WriteLine($"[Salty Chat] Error: {pluginError.Error} - Message: {pluginError.Message}");

                            break;
                        }
                }
            }
            catch (Exception e)
            {
                Debug.WriteLine($"[Salty Chat] Error: We received an error, but couldn't deserialize it:{Environment.NewLine}{e.ToString()}");
            }

            cb("");
        }
        #endregion

        #region Tick
        [Tick]
        private async Task FirstTick()
        {
            string resourceName = API.GetCurrentResourceName();

            this.ServerUniqueIdentifier = API.GetResourceMetadata(resourceName, "ServerUniqueIdentifier", 0);
            this.SoundPack = API.GetResourceMetadata(resourceName, "SoundPack", 0);
            this.IngameChannel = UInt64.Parse(API.GetResourceMetadata(resourceName, "IngameChannelId", 0));
            this.IngameChannelPassword = API.GetResourceMetadata(resourceName, "IngameChannelPassword", 0);

            string swissChannelIds = API.GetResourceMetadata(resourceName, "SwissChannelIds", 0);

            if (!String.IsNullOrEmpty(swissChannelIds))
            {
                this.SwissChannelIds = swissChannelIds.Split(',').Select(s => UInt64.Parse(s.Trim())).ToArray();
            }

            BaseScript.TriggerServerEvent(Event.SaltyChat_Initialize);

            this.Tick -= this.FirstTick;

            await Task.FromResult(0);
        }

        [Tick]
        private async Task OnControlTick()
        {
            Game.DisableControlThisFrame(0, Control.OpenJournal);
            Game.DisableControlThisFrame(0, Control.PushToTalk);
            //Game.DisableControlThisFrame(0, Control.OpenSatchelMenu);

            if (Game.Player.IsAlive)
            {
                if (Game.IsControlJustPressed(0, Control.FrontendLt))
                {
                    this.ToggleVoiceRange();
                }

                if (this.PrimaryRadioChannel != null)
                {
                    if (Game.IsControlJustPressed(0, Control.PushToTalk))
                        BaseScript.TriggerServerEvent(Event.SaltyChat_IsSending, this.PrimaryRadioChannel, true);
                    else if (Game.IsControlJustReleased(0, Control.PushToTalk))
                        BaseScript.TriggerServerEvent(Event.SaltyChat_IsSending, this.PrimaryRadioChannel, false);
                }

                if (this.SecondaryRadioChannel != null)
                {
                    if (Game.IsControlJustPressed(0, Control.OpenSatchelMenu))
                        BaseScript.TriggerServerEvent(Event.SaltyChat_IsSending, this.SecondaryRadioChannel, true);
                    else if (Game.IsControlJustReleased(0, Control.OpenSatchelMenu))
                        BaseScript.TriggerServerEvent(Event.SaltyChat_IsSending, this.SecondaryRadioChannel, false);
                }
            }

            await Task.FromResult(0);
        }

        [Tick]
        private async Task OnStateUpdateTick()
        {
            if (this.IsConnected && this.IsIngame)
            {
                List<PlayerState> playerStates = new List<PlayerState>();

                Vector3 playerPosition = Game.PlayerPed.Position;

                foreach (VoiceClient client in this.VoiceClients)
                {
                    if (client.Player == null)
                    {
                        client.Player = this.PlayerList[client.ServerId];

                        if (client.Player == null)
                            continue;
                    }

                    Ped ped = client.Player.Character;

                    if (!ped.Exists())
                        continue;

                    playerStates.Add(
                        new PlayerState(
                            client.TeamSpeakName,
                            ped.Position,
                            client.VoiceRange,
                            client.Player.IsAlive
                        )
                    );
                }

                this.ExecuteCommand(
                    new PluginCommand(
                        Command.BulkUpdate,
                        this.ServerUniqueIdentifier,
                        new BulkUpdate(
                            playerStates,
                            new SelfState(
                                playerPosition,
                                API.GetGameplayCamRot(0).Z
                            )
                        )
                    )
                );
            }

            await BaseScript.Delay(250);
        }
        #endregion

        #region Methods (Proximity)
        private void SetPlayerTalking(string teamSpeakName, bool isTalking)
        {
            Ped playerPed = null;
            VoiceClient voiceClient = this.VoiceClients.FirstOrDefault(v => v.TeamSpeakName == teamSpeakName);

            if (voiceClient != null)
            {
                playerPed = voiceClient.Player?.Character;
            }
            else if (teamSpeakName == this.TeamSpeakName)
            {
                playerPed = Game.PlayerPed;

                BaseScript.TriggerEvent(Event.SaltyChat_TalkStateChanged, isTalking);
            }

            if (playerPed != null)
            {
                //API.SetPlayerTalkingOverride(playerPed.Handle, isTalking);

                if (isTalking)
                    _ = playerPed.Tasks.PlayFacialAnimation("face_human@gen_male@base", "mood_talking_normal");
                else
                    _ = playerPed.Tasks.PlayFacialAnimation("face_human@gen_male@base", "mood_normal");
            }
        }

        /// <summary>
        /// Toggles voice range through <see cref="SharedData.VoiceRanges"/>
        /// </summary>
        public void ToggleVoiceRange()
        {
            int index = Array.IndexOf(SharedData.VoiceRanges, this.VoiceRange);

            if (index < 0)
            {
                this.VoiceRange = SharedData.VoiceRanges[1];
            }
            else if (index + 1 >= SharedData.VoiceRanges.Length)
            {
                this.VoiceRange = SharedData.VoiceRanges[0];
            }
            else
            {
                this.VoiceRange = SharedData.VoiceRanges[index + 1];
            }

            BaseScript.TriggerServerEvent(Event.SaltyChat_SetVoiceRange, this.VoiceRange);

            // ToDo
            //CitizenFX.Core.UI.Screen.ShowNotification($"New voice range is {VoiceManager._voiceRange} metres.");

            System.Drawing.Color color = System.Drawing.Color.FromArgb(255, 255, 255);

            BaseScript.TriggerEvent("chat:addMessage", new
            {
                color = new[] { color.R, color.G, color.B },
                args = new[] { "Salty Chat", $"Il range vocale è stato impostato a {this.VoiceRange} metri." }
            });
        }
        #endregion

        #region Methods (Plugin)
        private void InitializePlugin()
        {
            this.ExecuteCommand(
                new PluginCommand(
                    Command.Initiate,
                    new GameInstance(
                        this.ServerUniqueIdentifier,
                        this.TeamSpeakName,
                        this.IngameChannel,
                        this.IngameChannelPassword,
                        this.SoundPack,
                        this.SwissChannelIds
                    )
                )
            );
        }

        /// <summary>
        /// Plays a file from soundpack specified in <see cref="VoiceManager._soundPack"/>
        /// </summary>
        /// <param name="fileName">filename (without .wav) of the soundfile</param>
        /// <param name="loop">use <see cref="true"/> to let the plugin loop the sound</param>
        /// <param name="handle">use your own handle instead of the filename, so you can play the sound multiple times</param>
        public void PlaySound(string fileName, bool loop = false, string handle = null)
        {
            if (String.IsNullOrWhiteSpace(handle))
                handle = fileName;

            this.ExecuteCommand(
                new PluginCommand(
                    Command.PlaySound,
                    this.ServerUniqueIdentifier,
                    new Sound(
                        fileName,
                        loop,
                        handle
                    )
                )
            );
        }

        /// <summary>
        /// Stops and dispose the sound
        /// </summary>
        /// <param name="handle">filename or handle of the sound</param>
        public void StopSound(string handle)
        {
            this.ExecuteCommand(
                new PluginCommand(
                    Command.StopSound,
                    this.ServerUniqueIdentifier,
                    new Sound(handle)
                )
            );
        }

        private void ExecuteCommand(string funtion, object parameters)
        {
            API.SendNuiMessage(
                Newtonsoft.Json.JsonConvert.SerializeObject(new { Function = funtion, Params = parameters })
            );
        }

        private void ExecuteCommand(PluginCommand pluginCommand)
        {
            this.ExecuteCommand("runCommand", Util.ToJson(pluginCommand));
        }

        private void DisplayDebug(bool show)
        {
            this.ExecuteCommand("showBody", show);
        }
        #endregion
    }
}
