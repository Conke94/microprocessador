library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
   port( 
      clk      : in std_logic;
      endereco : in unsigned(6 downto 0);
      dado     : out unsigned(15 downto 0) 
   );
end entity;
architecture a_rom of rom is
   type mem is array (0 to 127) of unsigned(15 downto 0);
   constant conteudo_rom : mem := (
      0  => "0000101010000011",
      1  => "0001000011000011",

      2  => "0000000010000101",
      3  => "0000000011000001",

      4  => "0000000100000100",
      5  => "0000001000001010",
      6  => "0000000100000100",
      7  => "0010100000001111",
      8  => "0000000100000011",
      20 => "0000000010000100",
      21 => "0000010000001111",
      127 => "0000000000001111",
      others => (others=>'0')
   );
begin
   process(clk)
   begin
      if(rising_edge(clk)) then
         dado <= conteudo_rom(to_integer(endereco));
      end if;
   end process;
end architecture;