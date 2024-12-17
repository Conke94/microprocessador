-- VERIFICAR SE VAI PARA BRANCH DO CARRY
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
      0  => "0011110000000011", -- li s0,30;
      1  => "0000001000001100", -- sw s0,01;
      2  => "0000101001000011", -- li s1,5;
      3  => "0000011001001100", -- sw s1,03;
      4  => "0000001010001011", -- lw s2,01;
      5  => "0000100001001100", -- sw s1,04;
      6  => "0000011011001011", -- lw s3,03;
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