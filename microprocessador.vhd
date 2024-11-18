library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity microprocessador is
    port(
        clk, reset, wr_en : in std_logic;
        reg_read, reg_wr: in unsigned(2 downto 0);
        operation : unsigned(1 downto 0);
        ula_zero, ula_carry, jump_en : out std_logic;
        imm : in unsigned(15 downto 0);
        sel_imm : in std_logic
    );
end entity;

architecture a_microprocessador of microprocessador is 
    component banco is
        port(
        clk, reset, wr_en : in std_logic;
        reg_wr: in unsigned(2 downto 0);
        reg_read: in unsigned(2 downto 0);
        data_in : in unsigned(15 downto 0);
        data_out : out unsigned(15 downto 0)
    );
    end component;

    component ula is  
        port (   
        x,y : in unsigned(15 downto 0);
        out_a :  out unsigned(15 downto 0);
        operation : in unsigned(1 downto 0);
        flag_carry: out std_logic;
        flag_zero: out std_logic
    ); 
    end component;

    component reg16bits is
        port(
            clk, reset, wr_en : in std_logic;
            data_in : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        );
    end component;

    component rom is
        port( 
            clk      : in std_logic;
            endereco : in unsigned(6 downto 0);
            dado     : out unsigned(15 downto 0) 
         );
    end component;

    component pc is
        port(
            clk, reset, wr_en : in std_logic;
            data_in : in unsigned(6 downto 0);
            data_out : out unsigned(6 downto 0)
        );
    end component;

    component controller is
        port (   
            jump_en : out std_logic;
            clk, reset : in std_logic;
            last_adress : in unsigned(6 downto 0);
            adress_out :  out unsigned(6 downto 0);
            instruction : in unsigned(15 downto 0)
        );  
    end component;

    signal rom_out : unsigned(15 downto 0);
    signal endereco : unsigned(6 downto 0) := "0000000";
    signal pc_in : unsigned(6 downto 0) := "0000000";
    signal ula_out : unsigned(15 downto 0) := "0000000000000000";
    signal operando : unsigned(15 downto 0) := "0000000000000000";
    signal acumulador_value : unsigned(15 downto 0) := "0000000000000000";
    signal valor_registrador : unsigned(15 downto 0) := "0000000000000000";
    
    begin
        program_counter : pc PORT MAP(
            clk => clk, 
            reset => reset, 
            wr_en => '1', 
            data_in => pc_in, 
            data_out => endereco
        );

        controller_unit : controller PORT MAP (
            clk => clk, 
            reset => reset, 
            last_adress => endereco, 
            adress_out => pc_in, 
            instruction => rom_out, 
            jump_en => jump_en
        );

        rom_main : rom PORT MAP (
            clk => clk, 
            endereco => endereco, 
            dado => rom_out
        );

        banco_registradores : banco PORT MAP (
            clk=>clk,
            reset=>reset, 
            wr_en=>wr_en, 
            reg_wr=>reg_wr, 
            reg_read=>reg_read, 
            data_in=>imm,
            data_out=>valor_registrador
        );

        operando <= imm when sel_imm = '1' else valor_registrador;

        ula_main : ula PORT MAP(
            operation=>operation, 
            x=>acumulador_value,
            y=>operando,
            out_a=>ula_out, 
            flag_zero=>ula_zero,
            flag_carry=>ula_carry
        );

        acumulador : reg16bits PORT MAP(clk => clk, reset => reset, wr_en => wr_en, data_in => ula_out, data_out => acumulador_value);
end architecture;