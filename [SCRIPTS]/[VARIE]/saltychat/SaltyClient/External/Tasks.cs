using CitizenFX.Core;
using CitizenFX.Core.Native;
using System;
using System.Threading.Tasks;

namespace RedM.External
{
    public class Tasks
    {
        private Ped Ped { get; }

        internal Tasks(Ped ped)
        {
            this.Ped = ped;
        }

        /// <summary>
        /// Custom addition for facial animation native calls
        /// </summary>
        /// <param name="animDict"></param>
        /// <param name="animName"></param>
        public async Task PlayFacialAnimation(string animDict, string animName)
        {
            if (!API.HasAnimDictLoaded(animDict))
            {
                API.RequestAnimDict(animDict);
            }

            var end = API.GetGameTimer() + 1000;
            while (!API.HasAnimDictLoaded(animDict))
            {
                if (API.GetGameTimer() >= end)
                {
                    return;
                }

                await BaseScript.Delay(0);
            }

            API.SetFacialIdleAnimOverride(this.Ped.Handle, animName, animDict);
        }

        /// <summary>
        /// Custom addition for facial animation native calls
        /// </summary>
        /// <param name="animDict"></param>
        /// <param name="animName"></param>
        public void ClearFacialAnimation()
        {
            API.ClearFacialIdleAnimOverride(this.Ped.Handle);
        }
    }
}
