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
    class MyHorsesMenu
    {
        private static Menu myHorsesMenu = new Menu(GetConfig.Langs["TitleMenuHorses"], GetConfig.Langs["SubTitleMenuHorses"]);
        private static Menu subMenuManagmentHorse = new Menu("Horse Name", "");

        private static bool setupDone = false;
        private static void SetupMenu()
        {
            if (setupDone) return;
            setupDone = true;
            MenuController.AddMenu(myHorsesMenu);

            MenuController.EnableMenuToggleKeyOnController = false;
            MenuController.MenuToggleKey = (Control)0;

            MenuController.AddSubmenu(myHorsesMenu, subMenuManagmentHorse);

            //SubMenu Complements
            MenuController.AddSubmenu(subMenuManagmentHorse, BuyHorseCompsMenu.GetMenu());


            MenuItem buttonBuyComplements = new MenuItem(GetConfig.Langs["SubMenuBuyComplements"], GetConfig.Langs["SubMenuBuyComplements"])
            {
                RightIcon = MenuItem.Icon.SADDLE
            };
            subMenuManagmentHorse.AddMenuItem(buttonBuyComplements);
            MenuController.BindMenuItem(subMenuManagmentHorse, BuyHorseCompsMenu.GetMenu(), buttonBuyComplements);
            //

            MenuItem buttonSetDefaultHorse = new MenuItem(GetConfig.Langs["ButtonSetDefaultHorse"], GetConfig.Langs["ButtonSetDefaultHorse"])
            {
                RightIcon = MenuItem.Icon.TICK
            };
            subMenuManagmentHorse.AddMenuItem(buttonSetDefaultHorse);

            MenuItem buttonTransferHorse = new MenuItem(GetConfig.Langs["ButtonTransferHorse"], GetConfig.Langs["ButtonTransferHorse"])
            {
                RightIcon = MenuItem.Icon.STAR
            };
            subMenuManagmentHorse.AddMenuItem(buttonTransferHorse);

            MenuItem buttonDeleteHorse = new MenuItem(GetConfig.Langs["ButtonDeleteHorse"], GetConfig.Langs["ButtonDeleteHorse"])
            {
                RightIcon = MenuItem.Icon.LOCK
            };
            subMenuManagmentHorse.AddMenuItem(buttonDeleteHorse);


            //Events
            myHorsesMenu.OnMenuOpen += (_menu) => {

                myHorsesMenu.ClearMenuItems();

                MenuController.AddSubmenu(myHorsesMenu, subMenuManagmentHorse);

                foreach (var mh in HorseManagment.MyHorses)
                {
                    var Icon = MenuItem.Icon.SADDLE;

                    if (mh.IsDefault())
                    {
                        Icon = MenuItem.Icon.TICK;
                    }

                    MenuItem buttonMyHorses = new MenuItem(mh.getHorseName(), GetConfig.Langs[mh.getHorseModel()])
                    {

                        RightIcon = Icon

                    };
                    myHorsesMenu.AddMenuItem(buttonMyHorses);
                    MenuController.BindMenuItem(myHorsesMenu, subMenuManagmentHorse, buttonMyHorses);

                }

            };

            subMenuManagmentHorse.OnMenuClose += (_menu) =>
            {
                StablesShop.ExitMyHorseMode();
            };



            myHorsesMenu.OnItemSelect += (_menu, _item, _index) =>
            {
                StablesShop.indexHorseSelected = _index;
                StablesShop.MyHorseMode(_index);
                subMenuManagmentHorse.MenuTitle = HorseManagment.MyHorses[_index].getHorseName();

                if (HorseManagment.MyHorses[_index].IsDefault())
                {
                    buttonSetDefaultHorse.Enabled = false;
                }
                else
                {
                    buttonSetDefaultHorse.Enabled = true;
                }

                BuyHorseCompsMenu.LoadMyComps();
            };

            subMenuManagmentHorse.OnItemSelect += (_menu, _item, _index) =>
            {
                switch (_index)
                {
                    case 0:
                        StablesShop.MyhorseIsLoaded = true;
                        BuyHorseCompsMenu.LoadMyComps();
                        break;
                    case 1:
                        HorseManagment.MyHorses[StablesShop.indexHorseSelected].setDefault(true);
                        MenuController.CloseAllMenus();
                        break;
                    case 2:
                        StablesShop.TransferMyHorse(StablesShop.indexHorseSelected);
                        MenuController.CloseAllMenus();
                        break;
                    case 3:
                        StablesShop.DeleteMyHorse(StablesShop.indexHorseSelected);
                        MenuController.CloseAllMenus();
                        break;
                }
            };

        }



        public static Menu GetMenu()
        {
            SetupMenu();
            return myHorsesMenu;
        }

    }
}
