using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SaltyClient
{
    internal static class NuiEvent
    {
        internal const string SaltyChat_OnConnected = "SaltyChat_OnConnected";
        internal const string SaltyChat_OnDisconnected = "SaltyChat_OnDisconnected";
        internal const string SaltyChat_OnMessage = "SaltyChat_OnMessage";
        internal const string SaltyChat_OnError = "SaltyChat_OnError";
        internal const string SaltyChat_OnNuiReady = "SaltyChat_OnNuiReady";
    }
}
