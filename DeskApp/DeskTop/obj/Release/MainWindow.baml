   M S B A M L   `   `   `  ���� B  >DeskTop, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null!clr-namespace:DeskTopDeskTop      DeskTop.MainWindow   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35^ ZWindowsFormsIntegration, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     'localclr-namespace:DeskTop       � Title$  
MainWindow��$
��auto��$
��auto��$��1,1,3,3q�.��� $
��auto��$
��auto�� � ColumnDefinitions �� $	��100 ��� �� $��0* �.+�� $��0��.+��� $��1��$��0,16,0,0q�$
��auto��$
��auto��.+��� -    ��Name$ btnCustomers��$��	Customers��$��10q�$��30��$��12(�$
��Bold"����#fff8e3���#2e3137 � 	Resources  �� 
TargetType �� Property �� Value��%:   '��       �� " ��.���  �@��CornerRadius$ 15���� -   $ btnEmployees��$��	Employees��$��10q�$��30��$��12(�$
��Bold"����#fff8e3���#2e3137 ��%:   '��       �� " ��.���  �@��CornerRadius$ 15���� -   $ btnEmployees1��$��	Employees��$��10q�$��30��$��12(�$
��Bold"����#fff8e3���#2e3137 ��%:   '��       �� " ��.���  �@��CornerRadius$ 15���� -   $ btnEmployees2��$��	Employees��$��10q�$��30��$��12(�$
��Bold"����#fff8e3���#2e3137 ��%:   '��       �� " ��.���  �@��CornerRadius$ 15���� -   $ btnEmployees3��$��	Employees��$��10q�$��30��$��12(�$
��Bold"����#fff8e3���#2e3137 ��%:   '��       �� " ��.���  �@��CornerRadius$ 15���� -   $ btnEmployees4��$��	Employees��$��10q�$��30��$��12(�$
��Bold"����#fff8e3���#2e3137 ��%:   '��       �� " ��.���  �@��CornerRadius$ 15���� -   $ 
btnManager��$��Manager��$��10q�$��30��$��12(�$
��Bold"����#fff8e3���#2e3137 ��%:   '��       �� " ��.���  �@��CornerRadius$ 15��� $��1��$
��auto��$
��auto��.+��� -    ��Name$ CanCustomers��$
��auto��$
��auto��$y�Hidden=�.+� � -	     �Name$ frameCustomers��	  � Source$ 	 ./Customers/Customers.xaml?�
  � NavigationUIVisibility$
 Visible=�$
��Auto��$
��Auto���� -
   $ 
CanManager��$
��auto��$
��auto��$y�Hidden=�.+� � -   $ frameRegions��$	 ./Manager/Regions.xaml?�$
 Visible=�$
��Auto��$
��Auto��