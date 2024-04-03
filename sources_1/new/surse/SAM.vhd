library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SAM is
    Port ( x : in STD_LOGIC_VECTOR (31 downto 0);
           y : in STD_LOGIC_VECTOR (31 downto 0);
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           rez : out STD_LOGIC_VECTOR (63 downto 0));
end SAM;

architecture Behavioral of SAM is

component RCA is
    Port ( x : in STD_LOGIC_VECTOR (31 downto 0);
           y : in STD_LOGIC_VECTOR (31 downto 0);
           cin : in STD_LOGIC;
           rez : out STD_LOGIC_VECTOR (31 downto 0);
           cout : out STD_LOGIC);
end component;

type Signn is array (0 to 31) of std_logic_vector(63 downto 0);
signal sn:Signn:=(others => (others => '0'));
signal sum:Signn:=(others => (others => '0'));


signal aux: std_logic;
signal aux2: std_logic;
signal aux3: std_logic;
signal auxx2: std_logic_vector(31 downto 0):=(others => '0');
signal auxxx: std_logic_vector(31 downto 0):=(others => '0');
begin

process(x,sn,y,clk)
begin

if rising_edge(clk) then
if rst='1' then
sn<=(others => (others => '0'));
--sum<=(others => (others => '0'));
end if;
end if;
--else

for i in 0 to 31 loop
if y(i)='1' then
sn(i)(31+i downto i)<=x;
end if;
end loop;

end process;

loopp2: for i IN 0 to 30 generate 
  etaux:   RCA  port map (sum(i)(31 downto 0),sn(i)(31 downto 0),'0',sum(i+1)(31 downto 0),auxx2(i)); 
end generate;

loopp3: for i IN 0 to 30 generate 
  etaux2:   RCA  port map (sum(i)(63 downto 32),sn(i)(63 downto 32),auxx2(i),sum(i+1)(63 downto 32),auxxx(i)); 
end generate;

ett: RCA  port map (sum(31)(31 downto 0),sn(31)(31 downto 0),'0',rez(31 downto 0),aux); 
ettt: RCA  port map (sum(31)(63 downto 32),sn(31)(63 downto 32),aux,rez(63 downto 32),aux2); 


end Behavioral;
