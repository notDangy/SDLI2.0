using CitizenFX.Core;
using CitizenFX.Core.Native;
using MenuAPI;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static CitizenFX.Core.Native.API;

namespace vorpstables_cl
{
    public class StablesShop: BaseScript
    {
        public static int stableId;

        public static int CamHorse;
        public static int CamMyHorse;
        public static int CamCart;

        public static int HorsePed;
        public static int CartPed;
        public static bool horseIsLoaded = true;
        public static bool cartIsLoaded = true;
        public static bool MyhorseIsLoaded = false;
        public static bool MycartIsLoaded = false;

        public static int lIndex;
        public static int iIndex;

        public static int cIndex;

        #region HorseDataCache
        public static string horsemodel;
        public static double horsecost;

        public static int indexHorseSelected;
        public static int indexCartSelected;
        #endregion

        #region HorseCompsCache
        public static int indexCategory;
        public static int indexCategoryComp;
        public static int indexComp;
        #endregion

        public static async Task EnterBuyMode()
        {
            TriggerEvent("vorp:setInstancePlayer", true);
            int pId = PlayerPedId();

            FreezeEntityPosition(pId, true);

        }

        public static async Task ExitBuyMode()
        {
            TriggerEvent("vorp:setInstancePlayer", false);
            int pId = PlayerPedId();

            FreezeEntityPosition(pId, false);

        }

        public static async Task BuyHorseMode()
        {
            await EnterBuyMode();

            float Camerax = float.Parse(GetConfig.Config["Stables"][stableId]["CamHorse"][0].ToString());
            float Cameray = float.Parse(GetConfig.Config["Stables"][stableId]["CamHorse"][1].ToString());
            float Cameraz = float.Parse(GetConfig.Config["Stables"][stableId]["CamHorse"][2].ToString());
            float CameraRotx = float.Parse(GetConfig.Config["Stables"][stableId]["CamHorse"][3].ToString());
            float CameraRoty = float.Parse(GetConfig.Config["Stables"][stableId]["CamHorse"][4].ToString());
            float CameraRotz = float.Parse(GetConfig.Config["Stables"][stableId]["CamHorse"][5].ToString());

            CamHorse = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Camerax, Cameray, Cameraz, CameraRotx, CameraRoty, CameraRotz, 50.00f, false, 0);
            SetCamActive(CamHorse, true);
            RenderScriptCams(true, true, 1000, true, true, 0);
        }

        public static async Task BuyCartMode()
        {
            await EnterBuyMode();

            float Camerax = float.Parse(GetConfig.Config["Stables"][stableId]["CamCart"][0].ToString());
            float Cameray = float.Parse(GetConfig.Config["Stables"][stableId]["CamCart"][1].ToString());
            float Cameraz = float.Parse(GetConfig.Config["Stables"][stableId]["CamCart"][2].ToString());
            float CameraRotx = float.Parse(GetConfig.Config["Stables"][stableId]["CamCart"][3].ToString());
            float CameraRoty = float.Parse(GetConfig.Config["Stables"][stableId]["CamCart"][4].ToString());
            float CameraRotz = float.Parse(GetConfig.Config["Stables"][stableId]["CamCart"][5].ToString());

            CamHorse = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Camerax, Cameray, Cameraz, CameraRotx, CameraRoty, CameraRotz, 50.00f, false, 0);
            SetCamActive(CamHorse, true);
            RenderScriptCams(true, true, 1000, true, true, 0);
        }

        public static async Task MyHorseMode(int myHorseId)
        {
            await EnterBuyMode();

            float Camerax = float.Parse(GetConfig.Config["Stables"][stableId]["CamHorseGear"][0].ToString());
            float Cameray = float.Parse(GetConfig.Config["Stables"][stableId]["CamHorseGear"][1].ToString());
            float Cameraz = float.Parse(GetConfig.Config["Stables"][stableId]["CamHorseGear"][2].ToString());
            float CameraRotx = float.Parse(GetConfig.Config["Stables"][stableId]["CamHorseGear"][3].ToString());
            float CameraRoty = float.Parse(GetConfig.Config["Stables"][stableId]["CamHorseGear"][4].ToString());
            float CameraRotz = float.Parse(GetConfig.Config["Stables"][stableId]["CamHorseGear"][5].ToString());

            await LoadMyHorsePreview(stableId, myHorseId);

            CamMyHorse = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Camerax, Cameray, Cameraz, CameraRotx, CameraRoty, CameraRotz, 70.00f, false, 0);
            SetCamActive(CamMyHorse, true);
            RenderScriptCams(true, true, 1000, true, true, 0);
        }

        internal static void TransferMyHorse(int myHorseId)
        {
            TriggerEvent("vorpinputs:getInput", GetConfig.Langs["ButtonTransferHorse"], GetConfig.Langs["DeleteConfirmation"], new Action<dynamic>(async (cb) =>
            {
                string horseName = cb;

                await Delay(1000);

                if (!horseName.Equals("close"))
                {
                    if (horseName.ToLower().Equals(HorseManagment.MyHorses[myHorseId].getHorseName().ToLower()))
                    {
                        TriggerEvent("vorpinputs:getInput", GetConfig.Langs["ButtonTransferHorse"], GetConfig.Langs["InputServerId"], new Action<dynamic>(async (result) =>
                        {
                            int targetID; 

                            if(int.TryParse(result, out targetID))
                            {
                                int target = API.GetPlayerFromServerId(targetID);
                                foreach(int pl in API.GetActivePlayers())
                                {
                                    if (target == pl)
                                    {
                                        TriggerServerEvent("vorpstables:TransferHorse", HorseManagment.MyHorses[myHorseId].getHorseId(), targetID);
                                        if (HorseManagment.MyHorses[myHorseId].IsDefault())
                                        {
                                            HorseManagment.spawnedHorse = new Tuple<int, Horse>(-1, new Horse());
                                        }
                                        HorseManagment.MyHorses.RemoveAt(myHorseId);
                                    }
                                }
                            }
                            else
                            {
                                TransferMyHorse(myHorseId);
                            }

                        }));
                    }
                    else
                    {
                        TransferMyHorse(myHorseId);
                    }

                }


                }));
        }

        public static void DeleteMyHorse(int myHorseId)
        {
            TriggerEvent("vorpinputs:getInput", GetConfig.Langs["ButtonDeleteHorse"], GetConfig.Langs["DeleteConfirmation"], new Action<dynamic>(async (cb) =>
            {
                string horseName = cb;

                await Delay(1000);

                if (!horseName.Equals("close"))
                {
                    if (horseName.ToLower().Equals(HorseManagment.MyHorses[myHorseId].getHorseName().ToLower()))
                    {
                        TriggerServerEvent("vorpstables:RemoveHorse", HorseManagment.MyHorses[myHorseId].getHorseId());
                        if (HorseManagment.MyHorses[myHorseId].IsDefault())
                        {
                            HorseManagment.spawnedHorse = new Tuple<int, Horse>(-1, new Horse());
                        }
                        HorseManagment.MyHorses.RemoveAt(myHorseId);
                        TriggerEvent("vorp:TipRight", GetConfig.Langs["HorseDeleted"], 4000);
                    }
                    else
                    {
                        DeleteMyHorse(myHorseId);
                    }

                }
               
                
            }));

        }

        public static void DeleteMyCart(int myCartId)
        {
            TriggerEvent("vorpinputs:getInput", GetConfig.Langs["ButtonDeleteHorse"], GetConfig.Langs["DeleteConfirmation"], new Action<dynamic>(async (cb) =>
            {
                string horseName = cb;

                await Delay(1000);

                if (!horseName.Equals("close"))
                {
                    if (horseName.ToLower().Equals(HorseManagment.MyCarts[myCartId].getHorseName().ToLower()))
                    {
                        TriggerServerEvent("vorpstables:RemoveHorse", HorseManagment.MyCarts[myCartId].getHorseId());
                        if (HorseManagment.MyCarts[myCartId].IsDefault())
                        {
                            HorseManagment.spawnedCart = new Tuple<int, Cart>(-1, new Cart());
                        }
                        HorseManagment.MyCarts.RemoveAt(myCartId);
                        TriggerEvent("vorp:TipRight", GetConfig.Langs["HorseDeleted"], 4000);
                    }
                    else
                    {
                        DeleteMyHorse(myCartId);
                    }

                }


            }));

        }

        public static async Task ExitBuyHorseMode()
        {
            await ExitBuyMode();
            DeletePed(ref HorsePed);
            SetCamActive(CamHorse, false);
            RenderScriptCams(false, true, 1000, true, true, 0);
            DestroyCam(CamHorse, true);
        }

        public static async Task ExitMyHorseMode()
        {
            if (!MyhorseIsLoaded)
            {
                await ExitBuyMode();
                DeletePed(ref HorsePed);
                SetCamActive(CamMyHorse, false);
                RenderScriptCams(false, true, 1000, true, true, 0);
                DestroyCam(CamMyHorse, true);
            }
        }

        public static async Task ExitMyCartMode()
        {
            if (!MycartIsLoaded)
            {
                await ExitBuyMode();
                DeleteVehicle(ref CartPed);
                SetCamActive(CamMyHorse, false);
                RenderScriptCams(false, true, 1000, true, true, 0);
                DestroyCam(CamMyHorse, true);
            }
        }

        public static async Task ConfirmBuyCarriage()
        {
            MenuController.CloseAllMenus();

            if (HorseManagment.MyCarts.Count >= int.Parse(GetConfig.Config["StableSlots"].ToString()))
            {
                TriggerEvent("vorp:TipRight", GetConfig.Langs["StableIsFull"], 4000);
            }
            else
            {
                TriggerEvent("vorpinputs:getInput", GetConfig.Langs["InputCartNameButton"], GetConfig.Langs["InputCartNamePlaceholder"], new Action<dynamic>(async (cb) =>
                {
                    string cartName = cb;

                    await Delay(1000);

                    if (cartName.Length < 3)
                    {
                        TriggerEvent("vorp:TipRight", "~e~" + GetConfig.Langs["PlaceHolderInputName"], 3000); // from client side
                        ConfirmBuyCarriage();
                    }
                    else
                    {
                        if (!cartName.Equals("close"))
                        {
                            TriggerServerEvent("vorpstables:BuyNewCart", cartName, GetConfig.CartLists.ElementAt(cIndex).Key, GetConfig.CartLists.ElementAt(cIndex).Value);
                        }
                    }

                }));
            }
        }

        public static async Task ConfirmBuyHorse(string tittle)
        {
            MenuController.CloseAllMenus();

            if (HorseManagment.MyHorses.Count >= int.Parse(GetConfig.Config["StableSlots"].ToString()))
            {
                TriggerEvent("vorp:TipRight", GetConfig.Langs["StableIsFull"], 4000);
            }
            else
            {
                TriggerEvent("vorpinputs:getInput", GetConfig.Langs["InputNameButton"], GetConfig.Langs["InputNamePlaceholder"], new Action<dynamic>(async (cb) =>
                {
                    string horseName = cb;

                    await Delay(1000);

                    if (horseName.Length < 3)
                    {

                         TriggerEvent("vorp:TipRight", "~e~" + GetConfig.Langs["PlaceHolderInputName"], 3000); // from client side
                         ConfirmBuyHorse(tittle);
                    }
                    else
                    {
                        if (!horseName.Equals("close"))
                        {
                            TriggerServerEvent("vorpstables:BuyNewHorse", horseName, tittle, horsemodel, horsecost);
                            HorseManagment.isLoading = true;
                        }
                    }
                }));
            }
        }

        public static async Task BuyComp()
        {
            JObject newGear = new JObject();
            
            newGear["blanket"] = blanketsComp;

            newGear["horn"] = hornsComp;

            newGear["bag"] = saddlebagsComp;

            newGear["tail"] = tailsComp;

            newGear["mane"] = manesComp;

            newGear["saddle"] = saddlesComp;

            newGear["stirrups"] = stirrupsComp;

            newGear["bedroll"] = bedrollsComp;

            newGear["lantern"] = lanternComp;

            newGear["mask"] = maskComp;

            if (costComps != 0)
            {
                List<uint> cacheList = HorseManagment.MyComps;
                if (!HorseManagment.MyComps.Contains(blanketsComp) && blanketsComp != 0)
                {
                    cacheList.Add(blanketsComp);
                }
                if (!HorseManagment.MyComps.Contains(hornsComp) && hornsComp != 0)
                {
                    cacheList.Add(hornsComp);
                }
                if (!HorseManagment.MyComps.Contains(saddlebagsComp) && saddlebagsComp != 0)
                {
                    cacheList.Add(saddlebagsComp);
                }
                if (!HorseManagment.MyComps.Contains(tailsComp) && tailsComp != 1 && tailsComp != 0)
                {
                    cacheList.Add(tailsComp);
                }
                if (!HorseManagment.MyComps.Contains(manesComp) && manesComp != 1 && manesComp != 0)
                {
                    cacheList.Add(manesComp);
                }
                if (!HorseManagment.MyComps.Contains(saddlesComp) && saddlesComp != 0)
                {
                    cacheList.Add(saddlesComp);
                }
                if (!HorseManagment.MyComps.Contains(stirrupsComp) && stirrupsComp != 0)
                {
                    cacheList.Add(stirrupsComp);
                }
                if (!HorseManagment.MyComps.Contains(bedrollsComp) && bedrollsComp != 0)
                {
                    cacheList.Add(bedrollsComp);
                }
                if (!HorseManagment.MyComps.Contains(lanternComp) && lanternComp != 0)
                {
                    cacheList.Add(lanternComp);
                }
                if (!HorseManagment.MyComps.Contains(maskComp) && maskComp != 0)
                {
                    cacheList.Add(maskComp);
                }

                string array = Newtonsoft.Json.JsonConvert.SerializeObject(cacheList);

                TriggerServerEvent("vorpstables:BuyNewComp", array, costComps, newGear.ToString(), HorseManagment.MyHorses[indexHorseSelected].getHorseId());
                HorseManagment.isLoading = true;
            }
            else
            {
                TriggerServerEvent("vorpstables:UpdateComp", newGear.ToString(), HorseManagment.MyHorses[indexHorseSelected].getHorseId());
                HorseManagment.isLoading = true;
            }

            ExitMyHorseMode();
            MenuController.CloseAllMenus();
        }

        public static async Task LoadHorsePreview(int cat, int index, int ped2Delete)
        {
            horseIsLoaded = false;
            DeletePed(ref ped2Delete);
            float x = float.Parse(GetConfig.Config["Stables"][stableId]["SpawnHorse"][0].ToString());
            float y = float.Parse(GetConfig.Config["Stables"][stableId]["SpawnHorse"][1].ToString());
            float z = float.Parse(GetConfig.Config["Stables"][stableId]["SpawnHorse"][2].ToString());
            float heading = float.Parse(GetConfig.Config["Stables"][stableId]["SpawnHorse"][3].ToString());

            uint hashPed = (uint)GetHashKey(GetConfig.HorseLists.ElementAt(cat).Value.ElementAt(index).Key);

            await InitStables.LoadModel(hashPed);

            HorsePed = CreatePed(hashPed, x, y, z, heading, false, true, true, true);
            Function.Call((Hash)0x283978A15512B2FE, HorsePed, true);
            SetEntityCanBeDamaged(HorsePed, false);
            SetEntityInvincible(HorsePed, true);
            FreezeEntityPosition(HorsePed, true);
            SetModelAsNoLongerNeeded(hashPed);

            horseIsLoaded = true;
        }

        public static async Task LoadCartPreview(int index, int veh2Delete)
        {
            cartIsLoaded = false;
            DeleteVehicle(ref veh2Delete);
            float x = float.Parse(GetConfig.Config["Stables"][stableId]["SpawnCart"][0].ToString());
            float y = float.Parse(GetConfig.Config["Stables"][stableId]["SpawnCart"][1].ToString());
            float z = float.Parse(GetConfig.Config["Stables"][stableId]["SpawnCart"][2].ToString());
            float heading = float.Parse(GetConfig.Config["Stables"][stableId]["SpawnCart"][3].ToString());
            uint hashVeh = (uint)GetHashKey(GetConfig.CartLists.ElementAt(index).Key);

            await InitStables.LoadModel(hashVeh);

            CartPed = CreateVehicle(hashVeh, x, y, z, heading, false, true, true, true);
            Function.Call((Hash)0xAF35D0D2583051B0, CartPed, true);
            SetEntityCanBeDamaged(CartPed, false);
            SetEntityInvincible(CartPed, true);
            FreezeEntityPosition(CartPed, true);
            SetModelAsNoLongerNeeded(hashVeh);

            cartIsLoaded = true;
        }

        public static uint blanketsComp = 0;
        public static int blanketsCat = 0;
        public static uint hornsComp = 0;
        public static int hornsCat = 0;
        public static uint saddlebagsComp = 0;
        public static int saddlebagsCat = 0;
        public static uint tailsComp = 0;
        public static int tailsCat = 0;
        public static uint manesComp = 0;
        public static int manesCat = 0;
        public static uint saddlesComp = 0;
        public static int saddlesCat = 0;
        public static uint stirrupsComp = 0;
        public static int stirrupsCat = 0;
        public static uint bedrollsComp = 0;
        public static int bedrollsCat = 0;
        public static uint lanternComp = 0;
        public static int lanternCat = 0;
        public static uint maskComp = 0;
        public static int maskCat = 0;


        public static async Task LoadHorseCompsPreview(int cat, int subcat, int index)
        {
            Function.Call((Hash)0xC8A9481A01E63C28, HorsePed, 1);

            if (index == 0)
            {
                switch (cat)
                {
                    case 0:
                        blanketsComp = 0;
                        break;
                    case 1:
                        hornsComp = 0;
                        break;
                    case 2:
                        saddlebagsComp = 0;
                        break;
                    case 3:
                        tailsComp = 0;
                        break;
                    case 4:
                        manesComp = 0;
                        break;
                    case 5:
                        saddlesComp = 0;
                        break;
                    case 6:
                        stirrupsComp = 0;
                        break;
                    case 7:
                        bedrollsComp = 0;
                        break;
                    case 8:
                        lanternComp = 0;
                        break;
                    case 9:
                        maskComp = 0;
                        break;
                }
                
            }
            else
            {
                
                switch (cat)
                {
                    case 0:
                        blanketsComp = GetConfig.CompsLists.ElementAt(cat).Value.ElementAt(subcat).Value[index - 1];
                        blanketsCat = subcat;
                        break;
                    case 1:
                        hornsComp = GetConfig.CompsLists.ElementAt(cat).Value.ElementAt(subcat).Value[index - 1];
                        hornsCat = subcat;
                        break;
                    case 2:
                        saddlebagsComp = GetConfig.CompsLists.ElementAt(cat).Value.ElementAt(subcat).Value[index - 1];
                        saddlebagsCat = subcat;
                        break;
                    case 3:
                        if(index == 1)
                        {
                            tailsComp = 1;
                            tailsCat = -1;
                        }
                        else
                        {
                            tailsComp = GetConfig.CompsLists.ElementAt(cat).Value.ElementAt(subcat).Value[index - 2];
                            tailsCat = subcat;
                        }
                        break;
                    case 4:
                        if (index == 1)
                        {
                            manesComp = 1;
                            manesCat = -1;
                        }
                        else
                        {
                            manesComp = GetConfig.CompsLists.ElementAt(cat).Value.ElementAt(subcat).Value[index - 2];
                            manesCat = subcat;
                        }
                        break;
                    case 5:
                        saddlesComp = GetConfig.CompsLists.ElementAt(cat).Value.ElementAt(subcat).Value[index - 1];
                        saddlesCat = subcat;
                        break;
                    case 6:
                        stirrupsComp = GetConfig.CompsLists.ElementAt(cat).Value.ElementAt(subcat).Value[index - 1];
                        stirrupsCat = subcat;
                        break;
                    case 7:
                        bedrollsComp = GetConfig.CompsLists.ElementAt(cat).Value.ElementAt(subcat).Value[index - 1];
                        bedrollsCat = subcat;
                        break;
                    case 8:
                        lanternComp = GetConfig.CompsLists.ElementAt(cat).Value.ElementAt(subcat).Value[index - 1];
                        lanternCat = subcat;
                        break;
                    case 9:
                        maskComp = GetConfig.CompsLists.ElementAt(cat).Value.ElementAt(subcat).Value[index - 1];
                        maskCat = subcat;
                        break;
                }
            }
            CalcPrice();
            await ReloadComps();
        }

        public static async Task ReloadComps() 
        {
            if (blanketsComp != 0)
            {
                Function.Call((Hash)0xD3A7B003ED343FD9, HorsePed, blanketsComp, true, true, true);
            }
            else
            {
                Function.Call((Hash)0xD710A5007C2AC539, HorsePed, 0x17CEB41A, 0);
            }

            if (hornsComp != 0)
            {
                Function.Call((Hash)0xD3A7B003ED343FD9, HorsePed, hornsComp, true, true, true);
            }
            else
            {
                Function.Call((Hash)0xD710A5007C2AC539, HorsePed, 0x5447332, 0);
            }

            if (saddlebagsComp != 0)
            {
                Function.Call((Hash)0xD3A7B003ED343FD9, HorsePed, saddlebagsComp, true, true, true);
            }
            else
            {
                Function.Call((Hash)0xD710A5007C2AC539, HorsePed, 0x80451C25, 0);
            }
            
            if (tailsComp == 1)
            {
                Function.Call((Hash)0xD710A5007C2AC539, HorsePed, 0xA63CAE10, 0);
            }
            else if (tailsComp != 0)
            {
                Function.Call((Hash)0xD3A7B003ED343FD9, HorsePed, tailsComp, true, true, true);
            }

            if (manesComp == 1)
            {
                
                Function.Call((Hash)0xD710A5007C2AC539, HorsePed, 0xAA0217AB, 0);
            }
            else if (manesComp != 0)
            {
                Function.Call((Hash)0xD3A7B003ED343FD9, HorsePed, manesComp, true, true, true);
            }

            if (saddlesComp != 0)
            {
                Function.Call((Hash)0xD3A7B003ED343FD9, HorsePed, saddlesComp, true, true, true);
            }
            else
            {
                Function.Call((Hash)0xD710A5007C2AC539, HorsePed, 0xBAA7E618, 0);
            }
            
            if (stirrupsComp != 0)
            {
                Function.Call((Hash)0xD3A7B003ED343FD9, HorsePed, stirrupsComp, true, true, true);
            }
            else
            {
                Function.Call((Hash)0xD710A5007C2AC539, HorsePed, 0xDA6DADCA, 0);
            }

            if (bedrollsComp != 0)
            {
                Function.Call((Hash)0xD3A7B003ED343FD9, HorsePed, bedrollsComp, true, true, true);
            }
            else
            {
                Function.Call((Hash)0xD710A5007C2AC539, HorsePed, 0xEFB31921, 0);
            }

            if (lanternComp != 0)
            {
                Function.Call((Hash)0xD3A7B003ED343FD9, HorsePed, lanternComp, true, true, true);
            }
            else
            {
                Function.Call((Hash)0xD710A5007C2AC539, HorsePed, 0x1530BE1C, 0);
            }
            if (maskComp != 0)
            {
                Function.Call((Hash)0xD3A7B003ED343FD9, HorsePed, maskComp, true, true, true);
            }
            else
            {
                Function.Call((Hash)0xD710A5007C2AC539, HorsePed, 0xD3500E5D, 0);
            }


            Function.Call((Hash)0xCC8CA3E88256E58F, HorsePed, 0, 1, 1, 1, 0);

        }

        public static double costComps;

        public static async Task CalcPrice()
        {
            costComps = 0;
            if (!HorseManagment.MyComps.Contains(blanketsComp) && blanketsComp != 0)
            {
                costComps += GetConfig.CompsPrices.ElementAt(0).Value.ElementAt(blanketsCat).Value;
            }
            if (!HorseManagment.MyComps.Contains(hornsComp) && hornsComp != 0)
            {
                costComps += GetConfig.CompsPrices.ElementAt(1).Value.ElementAt(hornsCat).Value;
            }
            if (!HorseManagment.MyComps.Contains(saddlebagsComp) && saddlebagsComp != 0)
            {
                costComps += GetConfig.CompsPrices.ElementAt(2).Value.ElementAt(saddlebagsCat).Value;
            }
            if (!HorseManagment.MyComps.Contains(tailsComp) && tailsComp != 1 && tailsComp != 0)
            {
                costComps += GetConfig.CompsPrices.ElementAt(3).Value.ElementAt(tailsCat).Value;
            }
            if (!HorseManagment.MyComps.Contains(manesComp) && manesComp != 1 && manesComp != 0)
            {
                costComps += GetConfig.CompsPrices.ElementAt(4).Value.ElementAt(manesCat).Value;
            }
            if (!HorseManagment.MyComps.Contains(saddlesComp) && saddlesComp != 0)
            {
                costComps += GetConfig.CompsPrices.ElementAt(5).Value.ElementAt(saddlesCat).Value;
            }
            if (!HorseManagment.MyComps.Contains(stirrupsComp) && stirrupsComp != 0)
            {
                costComps += GetConfig.CompsPrices.ElementAt(6).Value.ElementAt(stirrupsCat).Value;
            }
            if (!HorseManagment.MyComps.Contains(bedrollsComp) && bedrollsComp != 0)
            {
                costComps += GetConfig.CompsPrices.ElementAt(7).Value.ElementAt(bedrollsCat).Value;
            }
            if (!HorseManagment.MyComps.Contains(lanternComp) && lanternComp != 0)
            {
                costComps += GetConfig.CompsPrices.ElementAt(8).Value.ElementAt(lanternCat).Value;
            }
            if (!HorseManagment.MyComps.Contains(maskComp) && maskComp != 0)
            {
                costComps += GetConfig.CompsPrices.ElementAt(9).Value.ElementAt(maskCat).Value;
            }
            Menus.BuyHorseCompsMenu.SetPriceButton(costComps);
        }



        public static async Task LoadMyHorsePreview(int stID, int index)
        {
            if (!MyhorseIsLoaded) {
                float x = float.Parse(GetConfig.Config["Stables"][stID]["SpawnHorse"][0].ToString());
                float y = float.Parse(GetConfig.Config["Stables"][stID]["SpawnHorse"][1].ToString());
                float z = float.Parse(GetConfig.Config["Stables"][stID]["SpawnHorse"][2].ToString());
                float heading = float.Parse(GetConfig.Config["Stables"][stID]["SpawnHorse"][3].ToString());

                uint hashPed = (uint)GetHashKey(HorseManagment.MyHorses[index].getHorseModel());

                await InitStables.LoadModel(hashPed);

                HorsePed = CreatePed(hashPed, x, y, z, heading, false, true, true, true);
                Function.Call((Hash)0x283978A15512B2FE, HorsePed, true);
                SetEntityCanBeDamaged(HorsePed, false);
                SetEntityInvincible(HorsePed, true);
                FreezeEntityPosition(HorsePed, true);
                SetModelAsNoLongerNeeded(hashPed);
            }


        }

    }
}
