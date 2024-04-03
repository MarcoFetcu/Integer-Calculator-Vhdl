library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ProiectALU is
Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end ProiectALU;


architecture Behavioral of ProiectALU is

component ALU is
    Port ( x : in STD_LOGIC_VECTOR (31 downto 0);
           y : in STD_LOGIC_VECTOR (31 downto 0);
           clk: in std_logic;
           en: in std_logic;
           op : in STD_LOGIC_VECTOR (3 downto 0);
           result : out STD_LOGIC_VECTOR (63 downto 0)
           );
end component;

component MPG is
   Port (
   clk : in  STD_LOGIC;
   inn: in STD_LOGIC;
   en: out  STD_LOGIC);    
end component;

component SSD is
    Port ( clk : in STD_LOGIC;
           digits : in STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component MEM is
    Port ( ra1 : in STD_LOGIC_VECTOR (3 downto 0);
           ra2 : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           en : in STD_LOGIC;         
           rd1 : out STD_LOGIC_VECTOR (31 downto 0);
           rd2 : out STD_LOGIC_VECTOR (31 downto 0));          
end component;

signal result: std_logic_vector(63 downto 0):=(others=>'0');
signal rez: std_logic_vector(63 downto 0):=(others=>'0');
signal do: std_logic_vector(15 downto 0):=(others=>'0');
signal x,y: std_logic_vector(31 downto 0):=(others=>'0');
signal oen,aen: std_logic;

begin
buton: MPG port map(clk,btn(0),oen);
b2: MPG port map(clk,btn(1),aen);

operands: MEM port map(sw(11 downto 8),sw(7 downto 4),clk,oen,x,y);

etalu: ALU port map(x,y,clk,oen,sw(15 downto 12),rez); 

result<=rez;

with sw(3 downto 0) select
    do<=
    rez(63 downto 48) when "1000",
    rez(47 downto 32) when "1100",
    rez(31 downto 16) when "1110",
    rez(15 downto 0) when "1111",
    x"000"&sw(15 downto 12) when "0000",
    x(31 downto 16) when "0010",
    x(15 downto 0) when "0011",
    y(31 downto 16) when "0100",
    y(15 downto 0) when "0110",
        (others=>'X') when others;
            
            
et4: SSD port map(clk,do,an,cat);



end Behavioral;
