using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SaltyServer
{
    public class VoiceClient
    {
        #region Props/Fields
        internal CitizenFX.Core.Player Player { get; set; }
        internal string TeamSpeakName { get; set; }
        internal float VoiceRange { get; set; }
        internal bool RadioSpeaker { get; set; }
        #endregion

        #region CTOR
        internal VoiceClient(CitizenFX.Core.Player player, string teamSpeakName, float voiceRange)
        {
            this.Player = player;
            this.TeamSpeakName = teamSpeakName;
            this.VoiceRange = voiceRange;
        }
        #endregion
    }
}
