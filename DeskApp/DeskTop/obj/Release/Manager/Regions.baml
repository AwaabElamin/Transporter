   M S B A M L   `   `   `  ���� B  >DeskTop, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null1clr-namespace:DeskTop.ManagerDeskTop.Manager      DeskTop.Manager.Regions   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35^ ZWindowsFormsIntegration, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     @d2http://schemas.microsoft.com/expression/blend/2008     /localclr-namespace:DeskTop.Manager     -   $
��Auto��$
��Auto��  N� FontSize$  18(� N� Title$ Regions��.���� -    ��Name$ CanRegionsView��$y�Visible=�$
��Left=�$
��auto��$
��auto��.+��  � RowDefinitions �� $��30 ��� $	��300 ��� $��30 �.+�� $��0��.+��� -    ��Name$ 
TabRegions��$
��auto��$
��auto��.@��� -    ��Name$ TabRegionsView��$
��Bold"����#fff8e3���#2e3137$��2,2,1,1q� J� Effect 3  -System.Windows.Media.Effects.DropShadowEffect  ����  �� Orientation$ 
Horizontal=�.+��� All Regions�� -   $ TabRegionsAdd��$
��Bold"����#fff8e3���#2e3137$��2,2,1,1q�   ���� $ 
Horizontal=�.+��� 
Add Region�� -   $ TabRegionsEdit��$
��Bold"����#fff8e3���#2e3137$��2,2,1,1q�   ���� $ 
Horizontal=�.+��� Edit Regions�� -   $ TabRegionsDeactive��$
��Bold"����#fff8e3���#2e3137$��2,2,1,1q�   ���� $ 
Horizontal=�.+��� 	Reports� $��1��.+��� -   $ 
CanRegions��$y�Visible=�$
��auto��$
��auto��.+��  �� $
��auto ��� $��30 �� $��0��.+��� -	   $ CanViewAllRegions��$y�Visible=�$
��auto��$
��auto��.+�� $
��Auto��$
��Auto�� �� $	��300 ��� $��40 �.+�� $��0��.+�&   System.Windows.Controls.DataGrid  -
     Name$ DGRegionsView��	   SelectionMode$	 Single=�
   CanUserReorderColumns
 .     
IsReadOnly . $��0,30,0,0q�� $��1���� -   $ CanAddRegion��$y�Hidden=�$
��auto��$
��auto��.+�� $
��Auto��$
��Auto�� �� $��50 ��� �� $��30 �.+�� $��0��� $��1�� �� $��45 ��� $��45 ��� $��45 �.+�� $��0�� � ColumnDefinitions �� $	��130 ��� �� $	��180 �.+�� $��0��.+��� -    ��Name$ lblRegionAddID��$��	Region ID��$��40��� $��1��.+��� -    ��Name$ txtRegionAddID��$	��200��$
��Left=�$��40��$��1,1,2,2q�A� -    A�Name$ ElipRegionAddID��$y�Hidden=�$��10��$��10��
���  ��� $��2��� $��1�� �� $	��130 ��� �� $	��180 �.+�� $��0��.+��� -   $ lblRegionAddDescription��$��Description��$��40��� $��1��.+��� -   $ txtRegionAddDesription��$	��200��$
��Left=�$��40��$��1,1,2,2q�A� -   $ ElipRegionAddDescription��$y�Hidden=�$��10��$��10��
���  ��� $��2��� $��2�� �� $	��130 ��� �� $	��180 �.+�� $��0��.+��� -   $ lblRegionAddActive��$��Active��$��40��� $��1��.+��� -    ��Name$ chkRegionAddActive��$
��Left=�$��Center=�$��40�� d� 	IsChecked$
 TrueY�A� -   $ ElipRegionAddActive��$y�Hidden=�$��10��$��10��
���  ��� $��2��� $��2�� �� $	��130 ��� .+�� $��0��.+��� -    ��Name$ btnRegionAddSubmit��$��Center=�$	��100��$��submit�����#fff8e3���#2e3137$
��Left=� � 	Resources  �� 
TargetType �� Property �� Value��%:   '��       �� " ��.���  �@��CornerRadius$ 15��� $��1��.+��� -   $ lblRegionAddError��$��Center=�$
��Bold"����	#FFE20F0F$�� ��$��40���� -   $ CanEditRegion��$y�Hidden=�$
��auto��$
��auto��.+�� $
��Auto��$
��Auto�� �� $��50 ��� �� $��30 �.+�� $��0��� $��1�� �� $��45 ��� $��45 ��� $��45 �.+�� $��0�� �� $	��130 ��� �� $	��180 �.+�� $��0��.+��� -   $ lblRegionEditID��$��	Region ID��$��40��� $��1��.+��� -   $ txtRegionEditID��$	��200��$
��Left=�$��40��$��1,1,2,2q�A� -   $ ElipRegionEditID��$y�Hidden=�$��10��$��10��
���  ��� $��2��� $��1�� �� $	��130 ��� �� $��80 �.+�� $��0��.+��� -   $ lblRegionEditDescription��$��Description��$��40��� $��1��.+��� -   $ txtRegionEditDesription��$
��Auto��$
��Left=�$��40��$��1,1,2,2q�A� -   $ ElipRegionEditDescription��$y�Hidden=�$��10��$��10��
���  ��� $��2��� $��2�� �� $	��130 ��� �� $	��180 �.+�� $��0��.+��� -   $ lblRegionEditActive��$��Active��$��40��� $��1��.+��� -   $ chkRegionEditActive��$
��Left=�$��Center=�$��40��$
 TrueY�� $��2��� $��2�� �� $	��130 ��� .+�� $��0��.+��� -    $ btnRegionEditSubmit��$��Center=�$	��100��$��submit�����#fff8e3���#2e3137$
��Left=� ��%:   '��       �� " ��.���  �@��CornerRadius$ 15��� $��1��.+��� -!   $ lblRegionEditError��$��Center=�$
��Bold"����	#FFE20F0F$�� ��$��40��� $��1��.+��� -"   $ lblRegionError�����	#FFF60808�� -#   $ 
CanReports��$y�Hidden=�$
��auto��$
��auto��.+��  �� �� �� .+�� $��0��� $��1��� $��2��� $��2��$	��0 1q� �� �� �� �� �� .+�� $��0�� �� $	��37* ��� $	��12* �.+��� -$   $ btnRegionInsert��$��
Add Region��$��2��� $��1��.+��� -%   $ btnRegionEdit��$��Edit  A Region��$	��1 0q�� $��2��.+��� -&   $ btnRegionActive��$��Active Regions��� $��3��.+��� -'   $ btnRegionDeactive��$��Deactive Regions��$	��1 0q�� $��4��.+��� -(   $ btnRegionAll��$��All Regions��