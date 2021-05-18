------------------------------------------------------------------------------
--	Paket fuer die Funktionen zur die Abbildung von ARM-Registeradressen
-- 	auf Adressen des physischen Registerspeichers (5-Bit-Adressen)
------------------------------------------------------------------------------
--	Datum:		05.11.2013
--	Version:	0.1
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.ArmTypes.all;

package ArmRegaddressTranslation is
  
	function get_internal_address(
		EXT_ADDRESS: std_logic_vector(3 downto 0); 
		THIS_MODE: std_logic_vector(4 downto 0); 
		USER_BIT : std_logic) 
	return std_logic_vector;

end package ArmRegaddressTranslation;

package body ArmRegAddressTranslation is

function get_internal_address(
	EXT_ADDRESS: std_logic_vector(3 downto 0);
	THIS_MODE: std_logic_vector(4 downto 0); 
	USER_BIT : std_logic) 
	return std_logic_vector 
is

--------------------------------------------------------------------------------		
--	Raum fuer lokale Variablen innerhalb der Funktion
	variable rueckgabe : std_logic_vector(4 downto 0);
	variable addresse : std_logic_vector(3 downto 0);
    variable modus : std_logic_vector(5 downto 0);
--------------------------------------------------------------------------------

	begin
--------------------------------------------------------------------------------		
--	Functionscode
		
		addresse := EXT_ADDRESS;
		modus := THIS_MODE & USER_BIT;

		if (addresse = "0000") then 	--0
			rueckgabe := "00000";
		elsif (addresse = "0001") then	--1
			rueckgabe := "00001";
		elsif (addresse = "0010") then	--2
			rueckgabe := "00010";
		elsif (addresse = "0011") then	--3
			rueckgabe := "00011";
		elsif (addresse = "0100") then	--4
			rueckgabe := "00100";
		elsif (addresse = "0101") then	--5
			rueckgabe := "00101";
		elsif (addresse = "0110") then	--6
			rueckgabe := "00110";
		elsif (addresse = "0111") then	--7
			rueckgabe := "00111";
		elsif (addresse = "1000") then	
			if(modus = "100010") then
				rueckgabe := "10000";	--16 fiq
			else
				rueckgabe := "01000";	--8
			end if;
		elsif (addresse = "1001") then	
			if(modus = "100010") then
				rueckgabe := "10001";	--17 fiq
			else
				rueckgabe := "01001";	--9
			end if;
		elsif (addresse = "1010") then	
			if(modus = "100010") then
				rueckgabe := "10010";	--18 fiq
			else
				rueckgabe := "01010";	--10
			end if;
		elsif (addresse = "1011") then	
			if(modus = "100010") then
				rueckgabe := "10011";	--19 fiq
			else
				rueckgabe := "01011";	--11
			end if;
		elsif (addresse = "1100") then	
			if(modus = "100010") then
				rueckgabe := "10100";	--20 fiq
			else
				rueckgabe := "01100";	--12
			end if;
		elsif (addresse = "1101") then
			if(modus = "100010") then -- USER NICHT GESETZT
				rueckgabe := "10101";	--21 fiq
			elsif(modus = "100100") then
				rueckgabe := "10111";	--23 irq
			elsif(modus = "100110") then
				rueckgabe := "11001";	--25 svc
			elsif(modus = "101110") then
				rueckgabe := "11011";	--27 abt
			elsif(modus = "110110") then
				rueckgabe := "11101";	--29 und
			else --USER GESETZT
				rueckgabe := "01101";	--13
			end if;
		elsif (addresse = "1110") then
			if(modus = "100010") then -- USER NICHT GESETZT
				rueckgabe := "10110";	--22 fiq
			elsif(modus = "100100") then
				rueckgabe := "11000";	--24 irq
			elsif(modus = "100110") then
				rueckgabe := "11010";	--26 svc
			elsif(modus = "101110") then
				rueckgabe := "11100";	--28 abt
			elsif(modus = "110110") then
				rueckgabe := "11110";	--30 und
			else --USER GESETZT
				rueckgabe := "01110";	--14
			end if;
		elsif (addresse = "1111") then
			rueckgabe := "01111";	--15
		else
			rueckgabe := "00000";
		end if;

--------------------------------------------------------------------------------		
		
	return rueckgabe;		

end function get_internal_address;	
	 
end package body ArmRegAddressTranslation;
