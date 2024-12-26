-- SALVA NO REGISTRADOR DA RAM (SIM)
-- PASSA PARA O ACUMULADOR (NÃO)
-- PASSA PARA O REGISTRADOR NO PRÓXIMO COMANDO (?)
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
      0  => "0000001000000011", -- li s0,1
      1  => "0001010001000011", -- li s1,10
      
      -- sw s1,0(s0)
      2  => "0000000001000101", -- mov A,s1
      3  => "0000000000001100", -- sw A,$s0

      4  => "1000000010000011", -- li s2,64
      5  => "0000101011000011", -- li s3,5

      -- sw s3,0(s2)
      6  => "0000000011000101", -- mov A,s3
      7  => "0000000010001100", -- sw A,$s2

      8  => "0000000100000011", -- li s4,0

      -- sw s1,0(s4)
      9  => "0000000001000101", -- mov A,s1
      10 => "0000000100001100", -- sw A,$s4

      -- lw s0,0(s2)
      11 => "0000000010001011", -- lw A,$s2
      12 => "0000000000000100", -- mov s0,A
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