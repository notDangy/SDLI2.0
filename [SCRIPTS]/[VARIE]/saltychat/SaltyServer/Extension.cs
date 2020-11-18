using System;
using System.Collections.Generic;
using System.Text;
using CitizenFX.Core;

namespace SaltyServer
{
    internal static class Extension
    {
        internal static void SendChatMessage(this Player player, string sender, string message)
        {
            player.TriggerEvent("chatMessage", sender, new int[] { 255, 0, 0 }, message);
        }
    }
}
