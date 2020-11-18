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
    class BuyCarriagesMenu
    {
        private static Menu buyCarriagesMenu = new Menu(GetConfig.Langs["TitleMenuBuyCarts"], GetConfig.Langs["SubTitleMenuBuyCarts"]);
        private static bool setupDone = false;
        private static void SetupMenu()
        {
            if (setupDone) return;
            setupDone = true;
            MenuController.AddMenu(buyCarriagesMenu);

            MenuController.EnableMenuToggleKeyOnController = false;
            MenuController.MenuToggleKey = (Control)0;

            Menu subMenuCartConfirmBuy = new Menu("Confirm Purcharse", "");
            MenuController.AddSubmenu(buyCarriagesMenu, subMenuCartConfirmBuy);

            MenuItem buttonCartConfirmYes = new MenuItem("", GetConfig.Langs["ConfirmBuyButtonDesc"])
            {
                RightIcon = MenuItem.Icon.SADDLE
            };
            subMenuCartConfirmBuy.AddMenuItem(buttonCartConfirmYes);
            MenuItem buttonCartConfirmNo = new MenuItem(GetConfig.Langs["CancelBuyButton"], GetConfig.Langs["CancelBuyButtonDesc"])
            {
                RightIcon = MenuItem.Icon.ARROW_LEFT
            };
            subMenuCartConfirmBuy.AddMenuItem(buttonCartConfirmNo);

            foreach (var cat in GetConfig.CartLists)
            {
                MenuItem _menuButton = new MenuItem(string.Format(GetConfig.Langs["ButtonCart"], GetConfig.Langs[cat.Key], cat.Value.ToString()), cat.Value.ToString())
                {
                    RightIcon = MenuItem.Icon.ARROW_RIGHT
                };
                buyCarriagesMenu.AddMenuItem(_menuButton);
                MenuController.BindMenuItem(buyCarriagesMenu, subMenuCartConfirmBuy, _menuButton);
            }

            buyCarriagesMenu.OnIndexChange += async (_menu, _oldItem, _newItem, _oldIndex, _newIndex) =>
            {
                Debug.WriteLine($"OnIndexChange: [{_menu}, {_oldItem}, {_newItem}, {_oldIndex}, {_newIndex}]");
                if (StablesShop.cartIsLoaded)
                {
                    await StablesShop.LoadCartPreview(_newIndex, StablesShop.CartPed);
                }
            };

            buyCarriagesMenu.OnItemSelect += (_menu, _item, _index) =>
            {
                subMenuCartConfirmBuy.MenuTitle = GetConfig.Langs[GetConfig.CartLists.ElementAt(_index).Key];
                subMenuCartConfirmBuy.MenuSubtitle = string.Format(GetConfig.Langs["subTitleConfirmBuy"], GetConfig.Langs[GetConfig.CartLists.ElementAt(_index).Key], GetConfig.CartLists.ElementAt(_index).Value.ToString());
                buttonCartConfirmYes.Label = string.Format(GetConfig.Langs["ConfirmBuyButton"], GetConfig.CartLists.ElementAt(_index).Value.ToString());
                StablesShop.cIndex = _index;
            };

            subMenuCartConfirmBuy.OnItemSelect += (_menu, _item, _index) =>
            {
                if (_index == 0)
                {
                    StablesShop.ConfirmBuyCarriage();
                }
                else
                {
                    subMenuCartConfirmBuy.CloseMenu();
                }
            };

            buyCarriagesMenu.OnMenuOpen += (_menu) =>
            {
                StablesShop.BuyCartMode();
                StablesShop.LoadCartPreview(0, StablesShop.CartPed);
            };

            buyCarriagesMenu.OnMenuClose += (_menu) =>
            {
                StablesShop.ExitMyCartMode();
            };

        }



        public static Menu GetMenu()
        {
            SetupMenu();
            return buyCarriagesMenu;
        }

    }
}
