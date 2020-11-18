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
    class MyCarriagesMenu
    {
        private static Menu myCartsMenu = new Menu(GetConfig.Langs["TitleMenuCarts"], GetConfig.Langs["SubTitleMenuCarts"]);
        private static Menu subMenuManagmentCarts = new Menu("Cart Name", "");

        private static bool setupDone = false;
        private static void SetupMenu()
        {
            if (setupDone) return;
            setupDone = true;
            MenuController.AddMenu(myCartsMenu);

            MenuController.EnableMenuToggleKeyOnController = false;
            MenuController.MenuToggleKey = (Control)0;

            MenuController.AddSubmenu(myCartsMenu, subMenuManagmentCarts);            

            MenuItem buttonSetDefaultCart = new MenuItem(GetConfig.Langs["ButtonSetDefaultHorse"], GetConfig.Langs["ButtonSetDefaultHorse"])
            {
                RightIcon = MenuItem.Icon.TICK
            };
            subMenuManagmentCarts.AddMenuItem(buttonSetDefaultCart);

            MenuItem buttonDeleteCart = new MenuItem(GetConfig.Langs["ButtonDeleteCart"], GetConfig.Langs["ButtonDeleteCart"])
            {
                RightIcon = MenuItem.Icon.LOCK
            };
            subMenuManagmentCarts.AddMenuItem(buttonDeleteCart);

            //Events

            myCartsMenu.OnMenuOpen += (_menu) => {

                myCartsMenu.ClearMenuItems();

                //MenuController.AddSubmenu(myCartsMenu, subMenuManagmentCarts);

                foreach (var mh in HorseManagment.MyCarts)
                {
                    var Icon = MenuItem.Icon.SADDLE;
                    if (mh.IsDefault())
                    {
                        Icon = MenuItem.Icon.TICK;
                    }

                    MenuItem buttonMyHorses = new MenuItem(mh.getHorseName(), GetConfig.Langs[mh.getHorseModel()])
                    {

                        RightIcon = Icon,

                    };

                    myCartsMenu.AddMenuItem(buttonMyHorses);
                    MenuController.BindMenuItem(myCartsMenu, subMenuManagmentCarts, buttonMyHorses);

                }

            };

            myCartsMenu.OnItemSelect += (_menu, _item, _index) =>
            {
                StablesShop.indexCartSelected = _index;
                subMenuManagmentCarts.MenuTitle = HorseManagment.MyCarts[_index].getHorseName();
                if (HorseManagment.MyCarts[_index].IsDefault())
                {
                    buttonSetDefaultCart.Enabled = false;
                }
                else
                {
                    buttonSetDefaultCart.Enabled = true;
                }
            };

            subMenuManagmentCarts.OnItemSelect += (_menu, _item, _index) =>
            {
                switch (_index)
                {
                    case 0:
                        HorseManagment.MyCarts[StablesShop.indexCartSelected].setDefault(true);
                        MenuController.CloseAllMenus();
                        break;
                    case 1:
                        StablesShop.DeleteMyCart(StablesShop.indexCartSelected);
                        MenuController.CloseAllMenus();
                        break;
                }
            };

        }



        public static Menu GetMenu()
        {
            SetupMenu();
            return myCartsMenu;
        }

    }
}
