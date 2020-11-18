using CitizenFX.Core;
using MenuAPI;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace vorpstables_cl.Menus
{
    class BuyHorseCompsMenu
    {
        private static Menu buyCompsMenu = new Menu(GetConfig.Langs["SubMenuBuyComplements"], " ");

        private static Menu subMenuCatComplementsHorseMantas = new Menu(GetConfig.CompsLists.ElementAt(0).Key, "");
        private static Menu subMenuCatComplementsHorseCuernos = new Menu(GetConfig.CompsLists.ElementAt(1).Key, "");
        private static Menu subMenuCatComplementsHorseAlforjas = new Menu(GetConfig.CompsLists.ElementAt(2).Key, "");
        private static Menu subMenuCatComplementsHorseColas = new Menu(GetConfig.CompsLists.ElementAt(3).Key, "");
        private static Menu subMenuCatComplementsHorseCrines = new Menu(GetConfig.CompsLists.ElementAt(4).Key, "");
        private static Menu subMenuCatComplementsHorseMonturas = new Menu(GetConfig.CompsLists.ElementAt(5).Key, "");
        private static Menu subMenuCatComplementsHorseEstribos = new Menu(GetConfig.CompsLists.ElementAt(6).Key, "");
        private static Menu subMenuCatComplementsHorsePetates = new Menu(GetConfig.CompsLists.ElementAt(7).Key, "");
        private static Menu subMenuCatComplementsHorseLantern = new Menu(GetConfig.CompsLists.ElementAt(8).Key, "");
        private static Menu subMenuCatComplementsHorseMask = new Menu(GetConfig.CompsLists.ElementAt(9).Key, "");

        private static MenuItem confirmBuy = new MenuItem("", " ")
        {
            RightIcon = MenuItem.Icon.STAR
        };

        private static bool setupDone = false;
        private static void SetupMenu()
        {
            if (setupDone) return;
            setupDone = true;
            MenuController.AddMenu(buyCompsMenu);

            MenuController.EnableMenuToggleKeyOnController = false;
            MenuController.MenuToggleKey = (Control)0;


            MenuController.AddSubmenu(buyCompsMenu, subMenuCatComplementsHorseMantas);
            MenuItem buttonBuyComplementsCatMantas = new MenuItem(GetConfig.CompsLists.ElementAt(0).Key, "")
            {
                RightIcon = MenuItem.Icon.SADDLE
            };
            buyCompsMenu.AddMenuItem(buttonBuyComplementsCatMantas);
            MenuController.BindMenuItem(buyCompsMenu, subMenuCatComplementsHorseMantas, buttonBuyComplementsCatMantas);

            MenuController.AddSubmenu(buyCompsMenu, subMenuCatComplementsHorseCuernos);

            MenuItem buttonBuyComplementsCatCuernos = new MenuItem(GetConfig.CompsLists.ElementAt(1).Key, "")
            {
                RightIcon = MenuItem.Icon.SADDLE
            };
            buyCompsMenu.AddMenuItem(buttonBuyComplementsCatCuernos);
            MenuController.BindMenuItem(buyCompsMenu, subMenuCatComplementsHorseCuernos, buttonBuyComplementsCatCuernos);

            
            MenuController.AddSubmenu(buyCompsMenu, subMenuCatComplementsHorseAlforjas);

            MenuItem buttonBuyComplementsCatAlforjas = new MenuItem(GetConfig.CompsLists.ElementAt(2).Key, "")
            {
                RightIcon = MenuItem.Icon.SADDLE
            };
            buyCompsMenu.AddMenuItem(buttonBuyComplementsCatAlforjas);
            MenuController.BindMenuItem(buyCompsMenu, subMenuCatComplementsHorseAlforjas, buttonBuyComplementsCatAlforjas);
            
            
            MenuController.AddSubmenu(buyCompsMenu, subMenuCatComplementsHorseColas);
            MenuItem buttonBuyComplementsCatColas = new MenuItem(GetConfig.CompsLists.ElementAt(3).Key, "")
            {
                RightIcon = MenuItem.Icon.SADDLE
            };
            buyCompsMenu.AddMenuItem(buttonBuyComplementsCatColas);
            MenuController.BindMenuItem(buyCompsMenu, subMenuCatComplementsHorseColas, buttonBuyComplementsCatColas);


            
            MenuController.AddSubmenu(buyCompsMenu, subMenuCatComplementsHorseCrines);
            MenuItem buttonBuyComplementsCatCrines = new MenuItem(GetConfig.CompsLists.ElementAt(4).Key, "")
            {
                RightIcon = MenuItem.Icon.SADDLE
            };
            buyCompsMenu.AddMenuItem(buttonBuyComplementsCatCrines);
            MenuController.BindMenuItem(buyCompsMenu, subMenuCatComplementsHorseCrines, buttonBuyComplementsCatCrines);


            
            MenuController.AddSubmenu(buyCompsMenu, subMenuCatComplementsHorseMonturas);
            MenuItem buttonBuyComplementsCatMonturas = new MenuItem(GetConfig.CompsLists.ElementAt(5).Key, "")
            {
                RightIcon = MenuItem.Icon.SADDLE
            };
            buyCompsMenu.AddMenuItem(buttonBuyComplementsCatMonturas);
            MenuController.BindMenuItem(buyCompsMenu, subMenuCatComplementsHorseMonturas, buttonBuyComplementsCatMonturas);

            MenuController.AddSubmenu(buyCompsMenu, subMenuCatComplementsHorseEstribos);
            MenuItem buttonBuyComplementsCatEstribos = new MenuItem(GetConfig.CompsLists.ElementAt(6).Key, "")
            {
                RightIcon = MenuItem.Icon.SADDLE
            };
            buyCompsMenu.AddMenuItem(buttonBuyComplementsCatEstribos);
            MenuController.BindMenuItem(buyCompsMenu, subMenuCatComplementsHorseEstribos, buttonBuyComplementsCatEstribos);
           
            MenuController.AddSubmenu(buyCompsMenu, subMenuCatComplementsHorsePetates);
            MenuItem buttonBuyComplementsCatPetates = new MenuItem(GetConfig.CompsLists.ElementAt(7).Key, "")
            {
                RightIcon = MenuItem.Icon.SADDLE
            };
            buyCompsMenu.AddMenuItem(buttonBuyComplementsCatPetates);
            MenuController.BindMenuItem(buyCompsMenu, subMenuCatComplementsHorsePetates, buttonBuyComplementsCatPetates);

            MenuController.AddSubmenu(buyCompsMenu, subMenuCatComplementsHorseLantern);
            MenuItem buttonBuyComplementsCatLantern = new MenuItem(GetConfig.CompsLists.ElementAt(8).Key, "")
            {
                RightIcon = MenuItem.Icon.SADDLE
            };
            buyCompsMenu.AddMenuItem(buttonBuyComplementsCatLantern);
            MenuController.BindMenuItem(buyCompsMenu, subMenuCatComplementsHorseLantern, buttonBuyComplementsCatLantern);

            MenuController.AddSubmenu(buyCompsMenu, subMenuCatComplementsHorseMask);
            MenuItem buttonBuyComplementsCatMask = new MenuItem(GetConfig.CompsLists.ElementAt(9).Key, "")
            {
                RightIcon = MenuItem.Icon.SADDLE
            };
            buyCompsMenu.AddMenuItem(buttonBuyComplementsCatMask);
            MenuController.BindMenuItem(buyCompsMenu, subMenuCatComplementsHorseMask, buttonBuyComplementsCatMask);

            buyCompsMenu.AddMenuItem(confirmBuy);

            //Events

            buyCompsMenu.OnItemSelect += (_menu, _item, _index) =>
            {
                if(_index == 10)
                {
                    StablesShop.BuyComp();
                }
                else
                {
                    StablesShop.indexCategory = _index;
                }


            };

            subMenuCatComplementsHorseMantas.OnListIndexChange += async (_menu, _listItem, _oldIndex, _newIndex, _itemIndex) =>
            {
                Debug.WriteLine($"OnListIndexChange: [{_menu}, {_listItem}, {_oldIndex}, {_newIndex}, {_itemIndex}]");
                foreach (MenuListItem algo in subMenuCatComplementsHorseMantas.GetMenuItems())
                {
                    if (algo.Index != _itemIndex)
                    {
                        algo.ListIndex = 0;
                    }
                }
                await StablesShop.LoadHorseCompsPreview(StablesShop.indexCategory, _itemIndex, _newIndex);
            };


            subMenuCatComplementsHorseCuernos.OnListIndexChange += async (_menu, _listItem, _oldIndex, _newIndex, _itemIndex) =>
            {
                Debug.WriteLine($"OnListIndexChange: [{_menu}, {_listItem}, {_oldIndex}, {_newIndex}, {_itemIndex}]");
                foreach (MenuListItem algo in subMenuCatComplementsHorseCuernos.GetMenuItems())
                {
                    if (algo.Index != _itemIndex)
                    {
                        algo.ListIndex = 0;
                    }
                }
                await StablesShop.LoadHorseCompsPreview(StablesShop.indexCategory, _itemIndex, _newIndex);
            };


            subMenuCatComplementsHorseAlforjas.OnListIndexChange += async (_menu, _listItem, _oldIndex, _newIndex, _itemIndex) =>
            {
                Debug.WriteLine($"OnListIndexChange: [{_menu}, {_listItem}, {_oldIndex}, {_newIndex}, {_itemIndex}]");
                foreach (MenuListItem algo in subMenuCatComplementsHorseAlforjas.GetMenuItems())
                {
                    if (algo.Index != _itemIndex)
                    {
                        algo.ListIndex = 0;
                    }
                }
                await StablesShop.LoadHorseCompsPreview(StablesShop.indexCategory, _itemIndex, _newIndex);
            };


            subMenuCatComplementsHorseColas.OnListIndexChange += async (_menu, _listItem, _oldIndex, _newIndex, _itemIndex) =>
            {
                Debug.WriteLine($"OnListIndexChange: [{_menu}, {_listItem}, {_oldIndex}, {_newIndex}, {_itemIndex}]");
                foreach (MenuListItem algo in subMenuCatComplementsHorseColas.GetMenuItems())
                {
                    if (algo.Index != _itemIndex)
                    {
                        algo.ListIndex = 0;
                    }
                }
                await StablesShop.LoadHorseCompsPreview(StablesShop.indexCategory, _itemIndex, _newIndex);
            };


            subMenuCatComplementsHorseCrines.OnListIndexChange += async (_menu, _listItem, _oldIndex, _newIndex, _itemIndex) =>
            {
                Debug.WriteLine($"OnListIndexChange: [{_menu}, {_listItem}, {_oldIndex}, {_newIndex}, {_itemIndex}]");
                foreach (MenuListItem algo in subMenuCatComplementsHorseCrines.GetMenuItems())
                {
                    if (algo.Index != _itemIndex)
                    {
                        algo.ListIndex = 0;
                    }
                }
                await StablesShop.LoadHorseCompsPreview(StablesShop.indexCategory, _itemIndex, _newIndex);
            };


            subMenuCatComplementsHorseMonturas.OnListIndexChange += async (_menu, _listItem, _oldIndex, _newIndex, _itemIndex) =>
            {
                Debug.WriteLine($"OnListIndexChange: [{_menu}, {_listItem}, {_oldIndex}, {_newIndex}, {_itemIndex}]");
                foreach (MenuListItem algo in subMenuCatComplementsHorseMonturas.GetMenuItems())
                {
                    if (algo.Index != _itemIndex)
                    {
                        algo.ListIndex = 0;
                    }
                }
                await StablesShop.LoadHorseCompsPreview(StablesShop.indexCategory, _itemIndex, _newIndex);
            };

            subMenuCatComplementsHorseEstribos.OnListIndexChange += async (_menu, _listItem, _oldIndex, _newIndex, _itemIndex) =>
            {
                Debug.WriteLine($"OnListIndexChange: [{_menu}, {_listItem}, {_oldIndex}, {_newIndex}, {_itemIndex}]");
                foreach (MenuListItem algo in subMenuCatComplementsHorseEstribos.GetMenuItems())
                {
                    if (algo.Index != _itemIndex)
                    {
                        algo.ListIndex = 0;
                    }
                }
                await StablesShop.LoadHorseCompsPreview(StablesShop.indexCategory, _itemIndex, _newIndex);
            };


            subMenuCatComplementsHorsePetates.OnListIndexChange += async (_menu, _listItem, _oldIndex, _newIndex, _itemIndex) =>
            {
                Debug.WriteLine($"OnListIndexChange: [{_menu}, {_listItem}, {_oldIndex}, {_newIndex}, {_itemIndex}]");
                foreach (MenuListItem algo in subMenuCatComplementsHorsePetates.GetMenuItems())
                {
                    if (algo.Index != _itemIndex)
                    {
                        algo.ListIndex = 0;
                    }
                }
                await StablesShop.LoadHorseCompsPreview(StablesShop.indexCategory, _itemIndex, _newIndex);
            };

            subMenuCatComplementsHorseLantern.OnListIndexChange += async (_menu, _listItem, _oldIndex, _newIndex, _itemIndex) =>
            {
                Debug.WriteLine($"OnListIndexChange: [{_menu}, {_listItem}, {_oldIndex}, {_newIndex}, {_itemIndex}]");
                foreach (MenuListItem algo in subMenuCatComplementsHorseLantern.GetMenuItems())
                {
                    if (algo.Index != _itemIndex)
                    {
                        algo.ListIndex = 0;
                    }
                }
                await StablesShop.LoadHorseCompsPreview(StablesShop.indexCategory, _itemIndex, _newIndex);
            };

            subMenuCatComplementsHorseMask.OnListIndexChange += async (_menu, _listItem, _oldIndex, _newIndex, _itemIndex) =>
            {
                Debug.WriteLine($"OnListIndexChange: [{_menu}, {_listItem}, {_oldIndex}, {_newIndex}, {_itemIndex}]");
                foreach (MenuListItem algo in subMenuCatComplementsHorseMask.GetMenuItems())
                {
                    if (algo.Index != _itemIndex)
                    {
                        algo.ListIndex = 0;
                    }
                }
                await StablesShop.LoadHorseCompsPreview(StablesShop.indexCategory, _itemIndex, _newIndex);
            };

            buyCompsMenu.OnMenuOpen += (_menu) => {

                StablesShop.CalcPrice();

            };

            buyCompsMenu.OnMenuClose += (_menu) =>
            {
                StablesShop.MyhorseIsLoaded = false;
            };

        }



        public static Menu GetMenu()
        {
            SetupMenu();
            return buyCompsMenu;
        }

        public static void LoadMyComps()
        {

            StablesShop.blanketsComp = 0;
            StablesShop.hornsComp = 0;
            StablesShop.saddlebagsComp = 0;
            StablesShop.tailsComp = 0;
            StablesShop.manesComp = 0;
            StablesShop.saddlesComp = 0;
            StablesShop.stirrupsComp = 0;
            StablesShop.bedrollsComp = 0;
            StablesShop.lanternComp = 0;
            StablesShop.maskComp = 0;


            //mantas
            subMenuCatComplementsHorseMantas.ClearMenuItems();

            foreach (var cat in GetConfig.CompsLists.ElementAt(0).Value)
            {
                List<string> clist = new List<string>();

                clist.Add(GetConfig.Langs["NoComplement"]);

                for (int i = 0; i < cat.Value.Count(); i++)
                {
                    clist.Add($"# {(i + 1).ToString()}");
                }

                int compindex = 0;
                JObject mygear = HorseManagment.MyHorses[StablesShop.indexHorseSelected].getGear();
                uint mycomp = HorseManagment.ConvertValue(mygear["blanket"].ToString());

                if (cat.Value.IndexOf(mycomp) != -1)
                {
                    compindex = cat.Value.IndexOf(mycomp) + 1;
                    StablesShop.blanketsComp = mycomp;
                }

                MenuListItem compCategoriesMantas = new MenuListItem(cat.Key, clist, compindex, GetConfig.CompsLists.ElementAt(0).Key + " - " + cat.Key);
                subMenuCatComplementsHorseMantas.AddMenuItem(compCategoriesMantas);
            }
            //end mantas

            //Horns
            subMenuCatComplementsHorseCuernos.ClearMenuItems();

            foreach (var cat in GetConfig.CompsLists.ElementAt(1).Value)
            {
                List<string> clist = new List<string>();

                clist.Add(GetConfig.Langs["NoComplement"]);

                for (int i = 0; i < cat.Value.Count(); i++)
                {
                    clist.Add($"# {(i + 1).ToString()}");
                }

                int compindex = 0;
                JObject mygear = HorseManagment.MyHorses[StablesShop.indexHorseSelected].getGear();
                uint mycomp = HorseManagment.ConvertValue(mygear["horn"].ToString());

                if (cat.Value.IndexOf(mycomp) != -1)
                {
                    compindex = cat.Value.IndexOf(mycomp) + 1;
                    StablesShop.hornsComp = mycomp;
                }

                MenuListItem compCategoriesCuernos = new MenuListItem(cat.Key, clist, compindex, GetConfig.CompsLists.ElementAt(1).Key + " - " + cat.Key);
                subMenuCatComplementsHorseCuernos.AddMenuItem(compCategoriesCuernos);
            }
            //end horns

            //saddlebags
            subMenuCatComplementsHorseAlforjas.ClearMenuItems();

            foreach (var cat in GetConfig.CompsLists.ElementAt(2).Value)
            {
                List<string> clist = new List<string>();

                clist.Add(GetConfig.Langs["NoComplement"]);

                for (int i = 0; i < cat.Value.Count(); i++)
                {
                    clist.Add($"# {(i + 1).ToString()}");
                }

                int compindex = 0;
                JObject mygear = HorseManagment.MyHorses[StablesShop.indexHorseSelected].getGear();
                uint mycomp = HorseManagment.ConvertValue(mygear["bag"].ToString());

                if (cat.Value.IndexOf(mycomp) != -1)
                {
                    compindex = cat.Value.IndexOf(mycomp) + 1;
                    StablesShop.saddlebagsComp = mycomp;
                }

                MenuListItem compCategoriesAlforjas = new MenuListItem(cat.Key, clist, compindex, GetConfig.CompsLists.ElementAt(2).Key + " - " + cat.Key);
                subMenuCatComplementsHorseAlforjas.AddMenuItem(compCategoriesAlforjas);
            }
            //end saddlebags

            //tails
            subMenuCatComplementsHorseColas.ClearMenuItems();

            foreach (var cat in GetConfig.CompsLists.ElementAt(3).Value)
            {
                List<string> clist = new List<string>();

                clist.Add(GetConfig.Langs["NoComplement"]);

                for (int i = 0; i < cat.Value.Count() + 1; i++)
                {
                    clist.Add($"# {(i + 1).ToString()}");
                }

                int compindex = 0;
                JObject mygear = HorseManagment.MyHorses[StablesShop.indexHorseSelected].getGear();
                uint mycomp = HorseManagment.ConvertValue(mygear["tail"].ToString());

                if (cat.Value.IndexOf(mycomp) != -1)
                {
                    compindex = cat.Value.IndexOf(mycomp) + 1;
                    StablesShop.tailsComp = mycomp;
                }

                MenuListItem compCategoriesColas = new MenuListItem(cat.Key, clist, compindex, GetConfig.CompsLists.ElementAt(3).Key + " - " + cat.Key);
                subMenuCatComplementsHorseColas.AddMenuItem(compCategoriesColas);
            }
            //end tail

            //manes
            subMenuCatComplementsHorseCrines.ClearMenuItems();

            foreach (var cat in GetConfig.CompsLists.ElementAt(4).Value)
            {
                List<string> clist = new List<string>();

                clist.Add(GetConfig.Langs["NoComplement"]);

                for (int i = 0; i < cat.Value.Count() + 1; i++)
                {
                    clist.Add($"# {(i + 1).ToString()}");
                }

                int compindex = 0;
                JObject mygear = HorseManagment.MyHorses[StablesShop.indexHorseSelected].getGear();
                uint mycomp = HorseManagment.ConvertValue(mygear["mane"].ToString());

                if (cat.Value.IndexOf(mycomp) != -1)
                {
                    compindex = cat.Value.IndexOf(mycomp) + 1;
                    StablesShop.manesComp = mycomp;
                }

                MenuListItem compCategoriesCrines = new MenuListItem(cat.Key, clist, compindex, GetConfig.CompsLists.ElementAt(4).Key + " - " + cat.Key);
                subMenuCatComplementsHorseCrines.AddMenuItem(compCategoriesCrines);
            }
            //end manes

            //saddles
            subMenuCatComplementsHorseMonturas.ClearMenuItems();

            foreach (var cat in GetConfig.CompsLists.ElementAt(5).Value)
            {
                List<string> clist = new List<string>();

                clist.Add(GetConfig.Langs["NoComplement"]);

                for (int i = 0; i < cat.Value.Count(); i++)
                {
                    clist.Add($"# {(i + 1).ToString()}");
                }

                int compindex = 0;
                JObject mygear = HorseManagment.MyHorses[StablesShop.indexHorseSelected].getGear();
                uint mycomp = HorseManagment.ConvertValue(mygear["saddle"].ToString());

                if (cat.Value.IndexOf(mycomp) != -1)
                {
                    compindex = cat.Value.IndexOf(mycomp) + 1;
                    StablesShop.saddlesComp = mycomp;
                }

                MenuListItem compCategoriesMonturas = new MenuListItem(cat.Key, clist, compindex, GetConfig.CompsLists.ElementAt(5).Key + " - " + cat.Key);
                subMenuCatComplementsHorseMonturas.AddMenuItem(compCategoriesMonturas);
            }
            //end saddles

            //stirrups
            subMenuCatComplementsHorseEstribos.ClearMenuItems();

            foreach (var cat in GetConfig.CompsLists.ElementAt(6).Value)
            {
                List<string> clist = new List<string>();

                clist.Add(GetConfig.Langs["NoComplement"]);

                for (int i = 0; i < cat.Value.Count(); i++)
                {
                    clist.Add($"# {(i + 1).ToString()}");
                }

                int compindex = 0;
                JObject mygear = HorseManagment.MyHorses[StablesShop.indexHorseSelected].getGear();
                uint mycomp = HorseManagment.ConvertValue(mygear["stirrups"].ToString());

                if (cat.Value.IndexOf(mycomp) != -1)
                {
                    compindex = cat.Value.IndexOf(mycomp) + 1;
                    StablesShop.stirrupsComp = mycomp;
                }

                MenuListItem compCategoriesEstribos = new MenuListItem(cat.Key, clist, compindex, GetConfig.CompsLists.ElementAt(6).Key + " - " + cat.Key);
                subMenuCatComplementsHorseEstribos.AddMenuItem(compCategoriesEstribos);
            }
            //end stirrups

            //bedrolls
            subMenuCatComplementsHorsePetates.ClearMenuItems();

            foreach (var cat in GetConfig.CompsLists.ElementAt(7).Value)
            {
                List<string> clist = new List<string>();

                clist.Add(GetConfig.Langs["NoComplement"]);

                for (int i = 0; i < cat.Value.Count(); i++)
                {
                    clist.Add($"# {(i + 1).ToString()}");
                }

                int compindex = 0;
                JObject mygear = HorseManagment.MyHorses[StablesShop.indexHorseSelected].getGear();
                uint mycomp = HorseManagment.ConvertValue(mygear["bedroll"].ToString());

                if (cat.Value.IndexOf(mycomp) != -1)
                {
                    compindex = cat.Value.IndexOf(mycomp) + 1;
                    StablesShop.bedrollsComp = mycomp;
                }

                MenuListItem compCategoriesPetates = new MenuListItem(cat.Key, clist, compindex, GetConfig.CompsLists.ElementAt(7).Key + " - " + cat.Key);
                subMenuCatComplementsHorsePetates.AddMenuItem(compCategoriesPetates);
            }
            //end bedrolls

            //Lamparas
            subMenuCatComplementsHorseLantern.ClearMenuItems();

            foreach (var cat in GetConfig.CompsLists.ElementAt(8).Value)
            {
                List<string> clist = new List<string>();

                clist.Add(GetConfig.Langs["NoComplement"]);

                for (int i = 0; i < cat.Value.Count(); i++)
                {
                    clist.Add($"# {(i + 1).ToString()}");
                }

                int compindex = 0;
                JObject mygear = HorseManagment.MyHorses[StablesShop.indexHorseSelected].getGear();
                uint mycomp = HorseManagment.ConvertValue(mygear["lantern"].ToString());

                if (cat.Value.IndexOf(mycomp) != -1)
                {
                    compindex = cat.Value.IndexOf(mycomp) + 1;
                    StablesShop.lanternComp = mycomp;
                }

                MenuListItem compCategoriesLantern = new MenuListItem(cat.Key, clist, compindex, GetConfig.CompsLists.ElementAt(8).Key + " - " + cat.Key);
                subMenuCatComplementsHorseLantern.AddMenuItem(compCategoriesLantern);
            }
            //end bedrolls

            //Mask
            subMenuCatComplementsHorseMask.ClearMenuItems();

            foreach (var cat in GetConfig.CompsLists.ElementAt(9).Value)
            {
                List<string> clist = new List<string>();

                clist.Add(GetConfig.Langs["NoComplement"]);

                for (int i = 0; i < cat.Value.Count(); i++)
                {
                    clist.Add($"# {(i + 1).ToString()}");
                }

                int compindex = 0;
                JObject mygear = HorseManagment.MyHorses[StablesShop.indexHorseSelected].getGear();
                uint mycomp = HorseManagment.ConvertValue(mygear["mask"].ToString());

                if (cat.Value.IndexOf(mycomp) != -1)
                {
                    compindex = cat.Value.IndexOf(mycomp) + 1;
                    StablesShop.maskComp = mycomp;
                }

                MenuListItem compCategoriesMask = new MenuListItem(cat.Key, clist, compindex, GetConfig.CompsLists.ElementAt(9).Key + " - " + cat.Key);
                subMenuCatComplementsHorseMask.AddMenuItem(compCategoriesMask);
            }
            //end bedrolls

            StablesShop.ReloadComps();
        }

        public static void SetPriceButton(double price)
        {
            confirmBuy.Label = string.Format(GetConfig.Langs["ConfirmBuyComplements"], price.ToString());
        }
    }
}
