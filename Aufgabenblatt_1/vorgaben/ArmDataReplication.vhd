--------------------------------------------------------------------------------
--	Datenreplikationseinheit fuer den Kern des ARM-SoC
--------------------------------------------------------------------------------
--	Datum:		29.10.2013
--	Version:	0.1
--------------------------------------------------------------------------------
--	Die Datenreplikationseinheit kann in der EX- oder MEM-Stufe
--	verwendet werden. In der gegenwaertigen Pipeline bietet sich die 
--	EX-Stufe an, Worte werden unveraendert weitergegeben,
--	Halbworte (immer die niederwertigen 16 Bit eines Datums aus einem ARM-
--	Register) werden auf dem niederwertigen und hochwertigen Halbwort
--	des Datenbus ausgegeben und Bytes auf alle 4 Bytes des Datenbus
--	repliziert. Auf diese Weise kann ohne weitere Anpassungen
--	in Little Endian und Big Endian Speicher geschrieben werden.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.armtypes.all;

entity ArmDataReplication is
	port (	DRP_INPUT	: in	std_logic_vector(31 downto 0);
			-- Data Memory Access Size
		 	DRP_DMAS	: in	std_logic_vector(1 downto 0);
		 	DRP_OUTPUT	: out	std_logic_vector(31 downto 0)
	);
end entity ArmDataReplication;

architecture behave of ArmDataReplication is
begin

	with DRP_DMAS select
	DRP_OUTPUT <= 
	-- niederwertigen Byte wird ausgegeben 
	((DRP_INPUT 7 downto 0) & DRP_INPUT(7 downto 0) & DRP_INPUT(7 downto 0)) & DRP_INPUT(7 downto 0)) when "00",
	-- niederwertigen 16 Bits werden ausgegeben
	(DRP_INPUT(15 downto 0) & DRP_INPUT(15 downto 0)) when "01",
	-- Eingangs des Moduls wird unverändert am Ausgang ausgegeben.
	DRP_IPUT when "10",
	DRP_INPUT when "11",
	"UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" when others; 

	
end architecture behave;
