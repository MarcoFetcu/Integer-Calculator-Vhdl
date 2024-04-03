library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity sim_ALU is
--  Port ( );
end sim_ALU;

architecture Behavioral of sim_ALU is

component ALU is
    Port ( x : in STD_LOGIC_VECTOR (31 downto 0);
           y : in STD_LOGIC_VECTOR (31 downto 0);
           clk: in std_logic;
           en: in std_logic;
           op : in STD_LOGIC_VECTOR (3 downto 0);
           result : out STD_LOGIC_VECTOR (63 downto 0)
           );
end component;
 signal x,y : std_logic_vector(31 downto 0);
 signal clk,en : std_logic;
signal op: STD_LOGIC_VECTOR (3 downto 0);
signal result: STD_LOGIC_VECTOR (63 downto 0);

begin

et: ALU port map(x,y,clk,en,op,result);

end Behavioral;
