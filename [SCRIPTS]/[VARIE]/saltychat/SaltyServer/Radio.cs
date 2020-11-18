using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SaltyShared;

namespace SaltyServer
{
    public class RadioChannel
    {
        #region Props/Fields
        internal string Name { get; }

        internal RadioChannelMember[] Members => this._members.ToArray();
        private List<RadioChannelMember> _members = new List<RadioChannelMember>();
        #endregion

        #region CTOR
        internal RadioChannel(string name, params RadioChannelMember[] members)
        {
            this.Name = name;

            if (members != null)
                this._members.AddRange(members);
        }
        #endregion

        #region Methods
        internal bool IsMember(VoiceClient voiceClient)
        {
            return this.Members.Any(m => m.VoiceClient == voiceClient);
        }

        internal void AddMember(VoiceClient voiceClient, bool isPrimary)
        {
            lock (this._members)
            {
                if (!this._members.Any(m => m.VoiceClient == voiceClient))
                {
                    this._members.Add(new RadioChannelMember(this, voiceClient, isPrimary));

                    voiceClient.Player.TriggerEvent(Event.SaltyChat_SetRadioChannel, this.Name, isPrimary);

                    foreach (RadioChannelMember member in this._members.Where(m => m.IsSending))
                    {
                        voiceClient.Player.TriggerEvent(Event.SaltyChat_IsSending, member.VoiceClient.Player.Handle, this.Name, true, false);
                    }
                }
            }
        }

        internal void RemoveMember(VoiceClient voiceClient)
        {
            lock (this._members)
            {
                RadioChannelMember member = this._members.FirstOrDefault(m => m.VoiceClient == voiceClient);

                if (member != null)
                {
                    if (member.IsSending)
                    {
                        if (member.VoiceClient.RadioSpeaker)
                        {
                            foreach (VoiceClient client in VoiceManager.Instance.VoiceClients)
                            {
                                client.Player.TriggerEvent(Event.SaltyChat_IsSendingRelayed, voiceClient.Player.Handle, this.Name, false, true, false, new string[0]);
                            }
                        }
                        else
                        {
                            foreach (RadioChannelMember channelMember in this._members)
                            {
                                channelMember.VoiceClient.Player.TriggerEvent(Event.SaltyChat_IsSending, voiceClient.Player.Handle, this.Name, false, true);
                            }
                        }
                    }

                    this._members.Remove(member);

                    foreach (RadioChannelMember channelMember in this._members.Where(m => m.IsSending))
                    {
                        voiceClient.Player.TriggerEvent(Event.SaltyChat_IsSending, channelMember.VoiceClient.Player.Handle, this.Name, false, false);
                    }

                    voiceClient.Player.TriggerEvent(Event.SaltyChat_SetRadioChannel, null, member.IsPrimary);
                }
            }
        }

        internal void Send(VoiceClient voiceClient, bool isSending)
        {
            if (!this.TryGetMember(voiceClient, out RadioChannelMember radioChannelMember))
                return;

            bool stateChanged = radioChannelMember.IsSending != isSending;
            radioChannelMember.IsSending = isSending;

            RadioChannelMember[] channelMembers = this.Members;
            RadioChannelMember[] onSpeaker = channelMembers.Where(m => m.VoiceClient.RadioSpeaker && m.VoiceClient != voiceClient).ToArray();

            if (onSpeaker.Length > 0)
            {
                string[] channelMemberNames = onSpeaker.Select(m => m.VoiceClient.TeamSpeakName).ToArray();

                foreach (VoiceClient remoteClient in VoiceManager.Instance.VoiceClients)
                {
                    remoteClient.Player.TriggerEvent(Event.SaltyChat_IsSendingRelayed, voiceClient.Player.Handle, this.Name, isSending, stateChanged, this.IsMember(remoteClient), channelMemberNames);
                }
            }
            else
            {
                foreach (RadioChannelMember member in channelMembers)
                {
                    member.VoiceClient.Player.TriggerEvent(Event.SaltyChat_IsSending, voiceClient.Player.Handle, this.Name, isSending, stateChanged);
                }
            }
        }
        #endregion

        #region Helper
        internal bool TryGetMember(VoiceClient voiceClient, out RadioChannelMember radioChannelMember)
        {
            radioChannelMember = this.Members.FirstOrDefault(m => m.VoiceClient == voiceClient);

            return radioChannelMember != null;
        }
        #endregion
    }

    internal class RadioChannelMember
    {
        internal RadioChannel RadioChannel { get; }
        internal VoiceClient VoiceClient { get; }
        internal bool IsPrimary { get; }
        internal bool IsSending { get; set; }

        internal RadioChannelMember(RadioChannel radioChannel, VoiceClient voiceClient, bool isPrimary)
        {
            this.RadioChannel = radioChannel;
            this.VoiceClient = voiceClient;
            this.IsPrimary = isPrimary;
        }
    }
}
