using CitizenFX.Core;
using CitizenFX.Core.Native;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace vorpstables_cl
{
    public class InitStables : BaseScript
    {
        public static List<int> StableBlips = new List<int>();
        public static List<int> StableNpc = new List<int>();

        public InitStables()
        {
            Tick += onStable;
        }

        public static async Task StartInit()
        {
            await Delay(10000);
            foreach (var stable in GetConfig.Config["Stables"])
            {
                //Creación de Blips
                int blipIcon = int.Parse(stable["BlipIcon"].ToString());
                float x = float.Parse(stable["EnterStable"][0].ToString());
                float y = float.Parse(stable["EnterStable"][1].ToString());
                float z = float.Parse(stable["EnterStable"][2].ToString());
                
                int _blip = Function.Call<int>((Hash)0x554D9D53F696D002, (uint)1664425300, x, y ,z);
                Function.Call((Hash)0x74F74D3207ED525C, _blip, blipIcon, 1);
                Function.Call((Hash)0x9CB1A1623062F402, _blip, stable["name"].ToString());

                StableBlips.Add(_blip);
                //end

                float xNpc = float.Parse(stable["StableNPC"][0].ToString());
                float yNpc = float.Parse(stable["StableNPC"][1].ToString());
                float zNpc = float.Parse(stable["StableNPC"][2].ToString());
                float hNpc = float.Parse(stable["StableNPC"][3].ToString());

                uint hashPed = (uint)API.GetHashKey("U_M_M_BwmStablehand_01");

                await LoadModel(hashPed);

                int _PedShop = API.CreatePed(hashPed, xNpc, yNpc, zNpc, hNpc, false, true, true, true);
                Function.Call((Hash)0x283978A15512B2FE, _PedShop, true);
                API.SetEntityNoCollisionEntity(API.PlayerPedId(), _PedShop, false);
                API.SetEntityCanBeDamaged(_PedShop, false);
                API.SetEntityInvincible(_PedShop, true);
                await Delay(1000);
                API.FreezeEntityPosition(_PedShop, true);
                StableNpc.Add(_PedShop);

                await Delay(200);
            }
        }


        public static async Task<bool> LoadModel(uint hash)
        {
            if (Function.Call<bool>(Hash.IS_MODEL_VALID, hash))
            {
                Function.Call(Hash.REQUEST_MODEL, hash);
                while (!Function.Call<bool>(Hash.HAS_MODEL_LOADED, hash))
                {
                    Debug.WriteLine($"Waiting for model {hash} load!");
                    await Delay(100);
                }
                return true;
            }
            else
            {
                Debug.WriteLine($"Model {hash} is not valid!");
                return false;
            }
        }

        [Tick]
        private async Task onStable()
        {
            if (StableNpc.Count() == 0) { return; }

            int pid = API.PlayerPedId();
            Vector3 pCoords = API.GetEntityCoords(pid, true, true);

            for (int i = 0; i < GetConfig.Config["Stables"].Count(); i++)
            {
                float x = float.Parse(GetConfig.Config["Stables"][i]["EnterStable"][0].ToString());
                float y = float.Parse(GetConfig.Config["Stables"][i]["EnterStable"][1].ToString());
                float z = float.Parse(GetConfig.Config["Stables"][i]["EnterStable"][2].ToString());
                float radius = float.Parse(GetConfig.Config["Stables"][i]["EnterStable"][3].ToString());

                if (API.GetDistanceBetweenCoords(pCoords.X, pCoords.Y, pCoords.Z, x, y, z, false) <= radius && !MenuAPI.MenuController.IsAnyMenuOpen())
                {
                    await DrawTxt(GetConfig.Langs["PressToOpen"], 0.5f, 0.9f, 0.7f, 0.7f, 255, 255, 255, 255, true, true);
                    if (API.IsControlJustPressed(2, 0xD9D0E1C0))
                    {
                        StablesShop.stableId = i;
                        HorseManagment.DeleteDefaultHorse();
                        Menus.MainMenu.GetMenu().OpenMenu();
                        await Delay(1000);
                    }
                }

            }

        }

        public async Task DrawTxt(string text, float x, float y, float fontscale, float fontsize, int r, int g, int b, int alpha, bool textcentred, bool shadow)
        {
            long str = Function.Call<long>(Hash._CREATE_VAR_STRING, 10, "LITERAL_STRING", text);
            Function.Call(Hash.SET_TEXT_SCALE, fontscale, fontsize);
            Function.Call(Hash._SET_TEXT_COLOR, r, g, b, alpha);
            Function.Call(Hash.SET_TEXT_CENTRE, textcentred);
            if (shadow) { Function.Call(Hash.SET_TEXT_DROPSHADOW, 1, 0, 0, 255); }
            Function.Call(Hash.SET_TEXT_FONT_FOR_CURRENT_COMMAND, 1);
            Function.Call(Hash._DISPLAY_TEXT, str, x, y);
        }

    }
}
