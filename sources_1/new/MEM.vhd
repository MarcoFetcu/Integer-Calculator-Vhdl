library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE ieee.std_logic_unsigned.all;

entity MEM is
    Port ( ra1 : in STD_LOGIC_VECTOR (3 downto 0);
           ra2 : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           en : in STD_LOGIC;         
           rd1 : out STD_LOGIC_VECTOR (31 downto 0);
           rd2 : out STD_LOGIC_VECTOR (31 downto 0));          
end MEM;

architecture Behavioral of MEM is

type memorie is array (0 to 15) of std_logic_vector(31 downto 0);

signal mem : memorie :=
(x"0000_0045", --0 --69
x"0000_000F", --1 --15
x"FFFF_FF6B", --2 -- -149
x"FFFF_FFE0", --3 -- -32
x"FFFF_FFFF", --4 --  -1
x"3FDE_476F", --5  -- 1.071.531.887
x"0000_0003", --6 --3
x"0000_0002", --7  --2
x"0000_0001", --8 --1
x"0000_0008", --9 --8
x"0A00_0001", --10 --167.772.161
x"0000_2201", --11
x"8000_0000", --12 --2.147.483.648
x"0123_4567", --13 --19.088.743
x"0000_4321", --14 -- 17.185
x"0000_0000", --15
others => x"00000000");


begin

process(clk)
begin
if rising_edge(clk) then
if en = '1' then

rd1 <= mem(conv_integer(ra1));
rd2 <= mem(conv_integer(ra2));

end if;
end if;
end process;
end Behavioral;
