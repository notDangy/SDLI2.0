/*
License (MIT)

Copyright 2019 Mooshe
https://github.com/MoosheTV/redm-external

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

using CitizenFX.Core.Native;

namespace RedM.External
{
    public static class Game
    {
        private static Player _player;
        public static Player Player
        {
            get {
                var handle = API.PlayerId();
                if (_player != null && handle == _player.Handle)
                {
                    return _player;
                }
                _player = new Player(handle);
                return _player;
            }
        }

        public static Ped PlayerPed => Player.Character;

		public static bool IsControlPressed(int index, Control control)
		{
			return API.IsDisabledControlPressed(index, (uint)control);
		}

		public static bool IsControlJustPressed(int index, Control control)
		{
			return API.IsDisabledControlJustPressed(index, (uint)control);
		}

		public static bool IsControlJustReleased(int index, Control control)
		{
			return API.IsDisabledControlJustReleased(index, (uint)control);
		}

		public static bool IsEnabledControlPressed(int index, Control control)
		{
			return API.IsControlPressed(index, (uint)control);
		}

		public static bool IsEnabledControlJustPressed(int index, Control control)
		{
			return API.IsControlJustPressed(index, (uint)control);
		}

		public static bool IsEnabledControlJustReleased(int index, Control control)
		{
			return API.IsControlJustReleased(index, (uint)control);
		}

		public static bool IsDisabledControlPressed(int index, Control control)
		{
			return IsControlPressed(index, control) && !IsControlEnabled(index, control);
		}

		public static bool IsDisabledControlJustPressed(int index, Control control)
		{
			return IsControlJustPressed(index, control) && !IsControlEnabled(index, control);
		}

		public static bool IsDisabledControlJustReleased(int index, Control control)
		{
			return IsControlJustReleased(index, control) && !IsControlEnabled(index, control);
		}

		public static bool IsControlEnabled(int index, Control control)
		{
			return API.IsControlEnabled(index, (uint)control);
		}

		public static void EnableControlThisFrame(int index, Control control)
		{
			API.EnableControlAction(index, (uint)control, true);
		}

		public static void DisableControlThisFrame(int index, Control control)
		{
			API.DisableControlAction(index, (uint)control, true);
		}

		public static void DisableAllControlsThisFrame(int index)
		{
			API.DisableAllControlActions(index);
		}

		public static float GetControlNormal(int index, Control control)
		{
			return API.GetControlNormal(index, (uint)control);
		}

		public static float GetDisabledControlNormal(int index, Control control)
		{
			return API.GetDisabledControlNormal(index, (uint)control);
		}

		public static int GetControlValue(int index, Control control)
		{
			return API.GetControlValue(index, (uint)control);
		}

		public static void SetControlNormal(int index, Control control, float value)
		{
			API.SetControlNormal(index, (uint)control, value);
		}

		public static void Pause(bool value)
        {
			API.SetGamePaused(value);
        }

		public static bool DoesGXTEntryExist(string entry)
        {
			return API.DoesTextLabelExist(entry);
        }

        public static string GetGXTEntry(string entry)
        {
			return DoesGXTEntryExist(entry) ? API.GetLabelText(entry) : string.Empty;
        }
    }
}
