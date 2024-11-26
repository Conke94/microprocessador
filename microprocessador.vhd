library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity microprocessador is
    port(
        clk, reset : in std_logic
    );
end entity;

architecture a_microprocessador of microprocessador is 
    component banco is
        port(
        clk, reset, wr_en : in std_logic;
        data_in : in unsigned(15 downto 0);
        data_out : out unsigned(15 downto 0);
        reg_wr, reg_read : in unsigned(2 downto 0)
    );
    end component;

    component ula is  
        port (   
        x,y : in unsigned(15 downto 0);
        out_a :  out unsigned(15 downto 0);
        operation : in unsigned(1 downto 0);
        flag_carry, flag_zero: out std_logic
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
            clk, reset : in std_logic;
            jump_en, wr_acumulador : out std_logic;
            operation : out unsigned(1 downto 0);
            last_adress : in unsigned(6 downto 0);
            adress_out :  out unsigned(6 downto 0);
            instruction : in unsigned(15 downto 0);
            registrador : out unsigned(2 downto 0);
            wr_reg : out std_logic
        );  
    end component;

    signal opcode: unsigned(3 downto 0);
    signal operation: unsigned(1 downto 0);
    signal registrador : unsigned(2 downto 0);
    signal endereco, pc_in : unsigned(6 downto 0) := "0000000";
    signal wr_acumulador, wr_reg, flag_zero, flag_carry, jump_en : std_logic;
    signal acumulador_value, ula_out, operando, valor_registrador, data_acumulador, instruction, imm : unsigned(15 downto 0) := "0000000000000000";
    
    begin
        banco_registradores : banco PORT MAP (clk, reset, wr_en => wr_reg, reg_wr => registrador, reg_read=>registrador, data_in=>imm,data_out=>valor_registrador);
        ula_main : ula PORT MAP(operation=>operation, x=>acumulador_value, y=>operando, out_a=>ula_out, flag_zero=>flag_zero, flag_carry=>flag_carry);
        acumulador : reg16bits PORT MAP(clk, reset, wr_en => wr_acumulador, data_in => data_acumulador, data_out => acumulador_value);
        program_counter : pc PORT MAP(clk, reset, wr_en => '1', data_in => pc_in, data_out => endereco);
        rom_main : rom PORT MAP (clk, endereco, dado => instruction);

        controller_unit : controller PORT MAP (
            clk, 
            reset, 
            last_adress => endereco, 
            adress_out => pc_in, 
            instruction => instruction,
            jump_en => jump_en,
            operation => operation,
            registrador => registrador,
            wr_acumulador => wr_acumulador,
            wr_reg => wr_reg
        );

        imm <= acumulador_value when opcode = "0100" else "000000000" & instruction(15 downto 9);
        opcode <= instruction(3 downto 0);
        
        operando <= imm when opcode = "0010" or opcode="1010" else valor_registrador;
        data_acumulador <= valor_registrador when opcode = "0101" else ula_out;
end architecture;