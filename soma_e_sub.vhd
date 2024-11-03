library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity soma_e_sub is
    port (   
        x,y       :  in  unsigned(15 downto 0);
        soma,subt :  out unsigned(15 downto 0)
    );  
 end entity;

 architecture a_soma_e_sub of soma_e_sub is
 begin
    soma <= x+y;
    subt <= x-y;
 end architecture;