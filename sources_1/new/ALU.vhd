library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( x : in STD_LOGIC_VECTOR (31 downto 0);
           y : in STD_LOGIC_VECTOR (31 downto 0);
           clk: in std_logic;
           en: in std_logic;
           op : in STD_LOGIC_VECTOR (3 downto 0);
           result : out STD_LOGIC_VECTOR (63 downto 0)
           );
end ALU;

architecture Behavioral of ALU is

component RCA is
    Port ( x : in STD_LOGIC_VECTOR (31 downto 0);
           y : in STD_LOGIC_VECTOR (31 downto 0);
           cin : in STD_LOGIC;
           rez : out STD_LOGIC_VECTOR (31 downto 0);
           cout : out STD_LOGIC);
end component;

component SAM is
    Port ( x : in STD_LOGIC_VECTOR (31 downto 0);
           y : in STD_LOGIC_VECTOR (31 downto 0);
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           rez : out STD_LOGIC_VECTOR (63 downto 0));
end component;

component DIV is
    Port ( 
	a : in std_logic_vector(63 downto 0);
	b : in std_logic_vector(31 downto 0);
	clk : in std_logic;
	reset : in std_logic;
	valid : out std_logic;
	result : out std_logic_vector(63 downto 0)
	);
end component;

signal andd,ysub,orr,nott,nott2,inc,dec,c2,roll,rorr,addd,subb,sx,sy: std_logic_vector(31 downto 0);
signal mul: std_logic_vector(63 downto 0);
signal divv: std_logic_vector(63 downto 0);
signal aux2: std_logic_vector(63 downto 0);
signal aux,auxx: std_logic;
signal valid: std_logic;

begin


andd<=x and y;
orr<=x or y;
nott<=not(x);
nott2<=not(y);

roll<=(x(30 downto 0) & x(31));
rorr<=(x(0) & x(31 downto 1));

process(ysub,sx,sy,clk)
begin
if rising_edge(clk) then
case op is 
when "0011" => sx<=x; sy<=x"00000001"; --inc
when "0100" => sx<=x; sy<=x"FFFFFFFF";  --dec
when "0101" => sx<=nott; sy<=x"00000001"; --c2
when "1001" => sx<=x; sy<=ysub; --sub
when others => sx<=x; sy<=y;
end case;
end if;
end process;



complement2y: RCA port map(nott2,x"00000000",'1',ysub,auxx);



adunare: RCA port map(sx,sy,'0',addd,aux);

aux2<=x"00000000"&x;
inmultire: SAM port map(x,y,en,clk,mul);
impartire: DIV port map(aux2,y,clk,'0',valid,divv);


process(op,andd,orr,nott,inc,dec,c2,roll,rorr,addd,subb,mul,divv)
begin
case op is 
when "0000" => result<=x"0000_0000" & andd;
when "0001" => result<=x"0000_0000" & orr;
when "0010" => result<=x"0000_0000" & nott;
when "0011" => result<=x"0000_0000" & addd; --inc; --
when "0100" => result<=x"0000_0000" & addd; --dec; --
when "0101" => result<=x"0000_0000" & addd; --c2; --
when "0110" => result<=x"0000_0000" & roll;
when "0111" => result<=x"0000_0000" & rorr;
when "1000" => result<=x"0000_000" & "000" & aux & addd; -- add
--when "1000" => result<=x"0000_0000" & addd; -- add
when "1001" => result<=x"0000_0000" & addd; --subb; 
when "1010" => result<=mul; 
when "1011" => 
if valid='1' then
result<=divv; 
end if; 
when others => result<=x"FFFF_FFFF_FFFF_FFFF";
end case;
end process;



end Behavioral;
