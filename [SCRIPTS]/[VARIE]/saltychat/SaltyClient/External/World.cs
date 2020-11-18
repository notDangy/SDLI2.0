/*
License (MIT)

Copyright 2019 Mooshe
https://github.com/MoosheTV/redm-external

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

using System;
using System.Threading.Tasks;
using CitizenFX.Core;
using CitizenFX.Core.Native;

namespace RedM.External
{
    public static class World
    {
        public static int CurrentDay => API.GetClockDayOfMonth();

        public static int CurrentMonth => API.GetClockMonth();

        public static int CurrentYear => API.GetClockYear();

        public static TimeSpan CurrentTime
        {
            get => new TimeSpan(API.GetClockHours(), API.GetClockMinutes(), API.GetClockSeconds());
            set => API.SetClockTime(value.Hours, value.Minutes, value.Seconds);
        }

        public static void SetClockDate(int day, int month, int year)
        {
            API.SetClockDate(day, month, year);
        }

        public static Vector2 World3dToScreen2d(Vector3 pos)
        {
            float screenX = 0f;
            float screenY = 0f;

            API.GetScreenCoordFromWorldCoord(pos.X, pos.Y, pos.Z, ref screenX, ref screenY);

            return new Vector2(screenX, screenY);
        }
    }

    [Flags]
    public enum IntersectOptions
    {
        Everything = -1,
        Map = 1,
        MissionEntities,
        Peds1 = 12,
        Objects = 16,
        Unk1 = 32,
        Unk2 = 64,
        Unk3 = 128,
        Vegetation = 256,
        Unk4 = 512
    }

    public enum WeatherType : uint
    {
        Overcast = 0xBB898D2D,
        Rain = 0x54A69840,
        Fog = 0xD61BDE01,
        Snowlight = 0x23FB812B,
        Thunder = 0xB677829F,
        Blizzard = 0x27EA2814,
        Snow = 0xEFB6EFF6,
        Misty = 0x5974E8E5,
        Sunny = 0x614A1F91,
        HighPressure = 0xF5A87B65,
        Clearing = 0x6DB1A50D,
        Sleet = 0xCA71D7C,
        Drizzle = 0x995C7F44,
        Shower = 0xE72679D5,
        SnowClearing = 0x641DFC11,
        OvercastDark = 0x19D4F1D9,
        Thunderstorm = 0x7C1C4A13,
        Sandstorm = 0xB17F6111,
        Hurricane = 0x320D0951,
        Hail = 0x75A9E268,
        Whiteout = 0x2B402288,
        GroundBlizzard = 0x7F622122
    }
}
