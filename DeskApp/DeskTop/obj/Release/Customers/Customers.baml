   M S B A M L   `   `   `  ���� B  >DeskTop, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null5clr-namespace:DeskTop.CustomersDeskTop.Customers  !    DeskTop.Customers.Customers   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35^ ZWindowsFormsIntegration, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     @d2http://schemas.microsoft.com/expression/blend/2008     1localclr-namespace:DeskTop.Customers     -   $
��Auto��$
��Auto��  N� FontSize$  18(� N� Title$ 	Customers��.���� -    ��Name$ CanMainCustomer��$y�Visible=�$
��Left=�$
��auto��$
��auto��.+�� -    �Name$ GridMainCustomer��$y�Visible=�$��Center=�$
��auto��$
��auto�� � RowDefinitions �� $
��auto ��� $
��auto �.+�� $��0��.+��� -    ��Name$ TabCustomers��$y�Visible=�$
��auto��$
��auto��.@��� -    ��Name$ TabViewCustomer��$
��Bold"����#fff8e3���#2e3137$��2,2,1,1q� J� Effect 3  -System.Windows.Media.Effects.DropShadowEffect  ����  �� Orientation$ 
Horizontal=�.+��� All Customers�� -   $ TabAddCustomer��$
��Bold"����#fff8e3���#2e3137$��2,2,1,1q�   ���� $ 
Horizontal=�.+��� Add A Customer�� -   $ TabEditCustomer��$
��Bold"����#fff8e3���#2e3137$��2,2,1,1q�   ���� $ 
Horizontal=�.+��� Edit A Customer�� -   $ TabDeactiveCustomers��$
��Bold"����#fff8e3���#2e3137$��2,2,1,1q�   ���� $ 
Horizontal=�.+��� Deactive Customers� $��1��.+��� -	   $ CanViewAllCustomer��$y�Visible=�$
��auto��$
��auto��.+�� $
��Auto��$
��Auto�� �� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto �.+�� $��0��� $��1��$	��0 5q�.+�&   System.Windows.Controls.DataGrid  -
   	  Name$	 DGCustomerView��
   SelectionMode$
 Single=�   CanUserReorderColumns .     
IsReadOnly . � $��2�� � ColumnDefinitions �� �� �� �� �� .+�� $��0��.+��� -    ��Name$ btnCustomerInsert��$��Add customer��� $��1��.+��� -   $ btnCustomerEdit��$��Edit customer��� $��2��.+��� -   $ btnCustomerActive��$��Active customers��� $��3��.+��� -   $ btnCustomerDeactive��$��Deactive customers��� $��4��.+��� -   $ btnCustomerAll��$��All customers��� $��3��$	��0 5q�#��� �� �� $��30 �.+�� $��0�� �� $
��auto ��� $
��auto ��� $
��auto �.+�� $��0�� �� $
��auto ��� $
��auto �.+�� $��0��.+��� -    ��Name$ lblCustomerRegionsFilter��$��	 Regions ��$��Center=�� $��1��.+��� -    ��Name$ cmboCustomerRegionsFilter��� $��1�� �� $
��auto ��� $
��auto ��� $
��auto �.+�� $��0��.+��� -   $" lblCustomerphoneNumberFilter��$�� Phone ��$��Center=�� $��1��.+��� -    ��Name$" txtCustomerPhoneNumberFilter��$	��140��$
��Left=�� $��2��.+��� -   $" btnCustomerPhoneNumberFilter��$��Go��$��Right=�� $��2�� �� $
��auto ��� $
��auto ��� $
��auto �.+�� $��0��.+��� -   $ lblCustomerEmailFilter��$�� Email ��$��Center=�� $��1��.+��� -   $ txtCustomerEmailFilter��$	��140��$
��Left=�� $��2��.+��� -   $ btnCustomerEmailFilter��$��Go��$��Right=�� $��4��#��� �� �� $
��Auto ��� $
��Auto ��� $
��Auto �.+�� $��0�� �� $
��auto ��� $
��auto ��� $
��auto �.+�� $��0��.+��� -   $  lblCustomerFirstNameFilter��$�� First Name ��$��Center=�� $��1��.+��� -   $  txtCustomerFirstNameFilter��$	��120��$
��Left=�� $��2��.+��� -   $  btnCustomerFirstNameFilter��$��Go��$��Right=�� $��1�� �� $
��auto ��� $
��auto ��� $
��auto �.+�� $��0��.+��� -   $ lblCustomerMidNameFilter��$�� Middle Name ��$��Center=�� $��1��.+��� -   $ txtCustomerMidNameFilter��$	��120��$
��Left=�� $��2��.+��� -   $ btnCustomerMidNameFilter��$��Go��$��Right=�� $��2�� �� $
��auto ��� $
��auto ��� $
��auto �.+�� $��0��.+��� -   $ lblCustomerLastNameFilter��$�� Last Name ��$��Center=�� $��1��.+��� -   $ txtCustomerLastNameFilter��$	��120��$
��Left=�� $��2��.+��� -    $ btnCustomerLastNameFilter��$��Go��$��Right=�� $��5�� �� �� �� .+�� $��0��.+��� -!   $ lblCustomerError��� $��1��� $��2��.+��� -"   $ btnCustomerReport���� -#   $ CanCustomerAdd��$y�hidden=�$
��auto��$
��auto��.+�� $	��800��$	��450�� �� $��50 ��� �� $��30 �.+�� $��0��� $��1�� �� $��45 ��� $��45 ��� $��45 ��� $��45 ��� $��45 ��� $��45 ��� $��45 ��� $��45 �.+�� $��0�� �� $	��130 ��� �� $	��180 �.+�� $��0��.+��� -$   $ lblCustomerAddFirstName��$��
First Name��$��40��� $��1��.+��� -%   $ txtCustomerAddFirstName��$	��200��$
��Left=�$��40��$��1,1,2,2q�A� -&    A�Name$ ElipCustomerAddFirstName��$y�Hidden=�$��10��$��10��
���  ��� $��2��� $��1�� �� $	��130 ��� �� $	��180 �.+�� $��0��.+��� -'   $ lblCustomerAddMIDName��$��Middle Name��$��40��� $��1��.+��� -(   $ txtCustomerAddMIDName��$	��200��$
��Left=�$��40��$��1,1,2,2q�A� -)   $ ElipCustomerAddMIDName��$y�Hidden=�$��10��$��10��
���  ��� $��2��� $��2�� �� $	��130 ��� �� $	��180 �.+�� $��0��.+��� -*   $ lblCustomerAddLastName��$��	Last Name��$��40��� $��1��.+��� -+   $ txtCustomerAddLastName��$	��200��$
��Left=�$��40��$��1,1,2,2q�A� -,   $ ElipCustomerAddLastName��$y�Hidden=�$��10��$��10��
���  ��� $��2��� $��3�� �� $	��130 ��� �� $	��180 �.+�� $��0��.+��� --   $ lblCustomerAddPhoneNumber��$��Phone Number��$��40��� $��1��.+��� -.   $ txtCustomerAddPhoneNumber��$	��200��$
��Left=�$��40��$��1,1,2,2q�A� -/   $  ElipCustomerAddPhoneNumber��$y�Hidden=�$��10��$��10��
���  ��� $��2��� $��4�� �� $	��130 ��� �� $	��180 �.+�� $��0��.+��� -0   $ lblCustomerAddEmail��$��Email��$��40��� $��1��.+��� -1   $ txtCustomerAddEmail��$	��200��$
��Left=�$��40��$��1,1,2,2q�A� -2   $ ElipCustomerAddEmail��$y�Hidden=�$��10��$��10��
���  ��� $��2��� $��5�� �� $	��130 ��� �� $	��180 �.+�� $��0��.+��� -3   $ lblCustomerAddRegionID��$��region��$��40��� $��1��.+��� -4   $ txtCustomerAddRegionID��$	��200��$
��Left=�$��40��$��1,1,2,2q�$y�Hidden=��� -5   $ comboCustomerAddRegionID��$	��200��$
��Left=�$��40��$��1,1,2,2q�A� -6   $ ElipCustomerAddRegionID��$y�Hidden=�$��10��$��10��
���  ��� $��2��� $��6�� �� $	��130 ��� �� $	��180 �.+�� $��0��.+��� -7   $ lblCustomerAddAddressLine��$��Address Line��$��40��� $��1��.+��� -8   $ txtCustomerAddAddressLine��$	��430��$
��Left=�$��40��$��1,1,2,2q�� $��2��.+�A� -9   $  ElipCustomerAddAddressLine��$y�Hidden=�$��10��$��10��
���  ��� $��7�� �� $	��130 ��� �� $	��180 �.+�� $��0��.+��� -:   $ lblCustomerAddActive��$��Active��$��40��� $��1��.+��� -;    ��Name$ chkCustomerAddActive��$
��Left=�$��Center=�$��40�� d� 	IsChecked$
 TrueY�� $��2��� $��2�� �� $	��130 ��� .+�� $��0��.+��� -<   $ btnCustomerAddSubmit��$��Center=�$	��100��$��submit�����#fff8e3���#2e3137$
��Left=� � 	Resources  �� 
TargetType �� Property �� Value��%:   '��       �� " ��.���  �@��CornerRadius$ 15��� $��1��.+��� -=   $ lblCustomerAddError��$��Center=�$
��Bold"����	#FFE20F0F$�� ��$��40���� ->   $ CanCustomerEdit��$y�Hidden=�$
��auto��$
��auto��.+�� $	��800��$	��450�� �� $��50 ��� �� $��30 �.+�� $��0��� $��1�� �� $��45 ��� $��45 ��� $��45 ��� $��45 ��� $��45 ��� $��45 ��� $��45 ��� $��45 �.+�� $��0�� �� $	��130 ��� �� $	��180 �.+�� $��0��.+��� -?   $ lblCustomerEditFirstName��$��
First Name��$��40��� $��1��.+��� -@   $ txtCustomerEditFirstName��$	��200��$
��Left=�$��40��$��1,1,2,2q�A� -A   $ ElipCustomerEditFirstName��$y�Hidden=�$��10��$��10��
���  ��� $��2��� $��1�� �� $	��130 ��� �� $	��180 �.+�� $��0��.+��� -B   $ lblCustomerEditMIDName��$��Middle Name��$��40��� $��1��.+��� -C   $ txtCustomerEditMIDName��$	��200��$
��Left=�$��40��$��1,1,2,2q�A� -D   $ ElipCustomerEditMIDName��$y�Hidden=�$��10��$��10��
���  ��� $��2��� $��2�� �� $	��130 ��� �� $	��180 �.+�� $��0��.+��� -E   $ lblCustomerEditLastName��$��	Last Name��$��40��� $��1��.+��� -F   $ txtCustomerEditLastName��$	��200��$
��Left=�$��40��$��1,1,2,2q�A� -G   $ ElipCustomerEditLastName��$y�Hidden=�$��10��$��10��
���  ��� $��2��� $��3�� �� $	��130 ��� �� $	��180 �.+�� $��0��.+��� -H   $  lblCustomerEditPhoneNumber��$��Phone Number��$��40��� $��1��.+��� -I   $  txtCustomerEditPhoneNumber��$	��200��$
��Left=�$��40��$��1,1,2,2q�A� -J   $! ElipCustomerEditPhoneNumber��$y�Hidden=�$��10��$��10��
���  ��� $��2��� $��4�� �� $	��130 ��� �� $	��180 �.+�� $��0��.+��� -K   $ lblCustomerEditEmail��$��Email��$��40��� $��1��.+��� -L   $ txtCustomerEditEmail��$	��200��$
��Left=�$��40��$��1,1,2,2q�A� -M   $ ElipCustomerEditEmail��$y�Hidden=�$��10��$��10��
���  ��� $��2��� $��5�� �� $	��130 ��� $	��220 ��� $	��300 �.+�� $��0��.+��� -N   $ lblCustomerEditRegionID��$��region��$��40��� $��1��.+��� -O   $ txtCustomerEditRegionID��$	��200��$
��Left=�$��40��$��1,1,2,2q�$y�Visible=� �� 
IsReadOnly . � $��2��.+��� -P   $ ComboCustomerEditRegionID��$	��200��$
��Left=�$��40��$��1,1,2,2q�A� -Q   $ ElipCustomerEditRegionID��$y�Hidden=�$��10��$��10��
���  ��$��Right=�� $��6�� �� $	��130 ��� �� $	��180 �.+�� $��0��.+��� -R   $  lblCustomerEditAddressLine��$��Address Line��$��40��� $��1��.+��� -S   $  txtCustomerEditAddressLine��$	��430��$
��Left=�$��40��$��1,1,2,2q�� $��2��.+�A� -T   $! ElipCustomerEditAddressLine��$y�Hidden=�$��10��$��10��
���  ��� $��7�� �� $	��130 ��� �� $	��180 �.+�� $��0��.+��� -U   $ lblCustomerEditActive��$��Active��$��40��� $��1��.+��� -V   $ chkCustomerEditActive��$
��Left=�$��Center=�$��40��$
 TrueY�� $��2��� $��2�� �� $	��130 ��� .+�� $��0��.+��� -W   $ btnCustomerEditSubmit��$��Center=�$	��100��$��submit�����#fff8e3���#2e3137$
��Left=� ��%:   '��       �� " ��.���  �@��CornerRadius$ 15��� $��1��.+��� -X   $ lblCustomerEditError��$��Center=�$
��Bold"����	#FFE20F0F$�� ��$��40���� -Y   $ CanCustomerDeactive��$y�Hidden=�$
��auto��$
��auto��.+�� $	��800��$	��450�� �� $��40 ��� $	��300 ��� $��40 ��� $��80 �.+�� $��0��� $��1��.+�  -Z   $	 DGCustomerDeativeView��$
 Single=� .   . � $��2�� �� �� �� �� .+�� $��0��.+��� -[   $ btnCustomerDelete��$��Delete customer��� $��1��.+��� -\   $ btnCustomerActivate��$��Activate customer��� $��2��� $��3��� $��3��.+��� -]   $ lblCustomerDeactiveError��