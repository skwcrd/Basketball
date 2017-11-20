Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

Entity Top is
Port(
	CLK,Rstb : in std_logic;
	iPush1,iPush2,iPush3,iPush4 : in std_logic
	--Sw1,Sw2,Sw3,Sw4 : in std_logic;
	--Change : in std_logic;
	--oBuzz : out std_logic;
	--oLED : out std_logic_vector(7 downto 0);
	--oBCD : out std_logic_vector(6 downto 0);
	--com : out std_logic_vector(3 downto 0);
	--dp : out std_logic
);
End Top;

Architecture Structural of Top is
	
	Component CLK1ms
	Port(
		CLK : in std_logic;
		Rstb : in std_logic;
		o1ms : out std_logic
	);
	End Component CLK1ms;
	
	Component Debouce is
	Port(
		CLK : in std_logic;
		Rstb : in std_logic;
		i1ms : in std_logic;
		I : in std_logic;
		O : out std_logic
	);
	End Component Debouce;
	
	--Component TimeTop is
	--Port(
	--	CLK,Rstb : in std_logic;
	--	iPushS,iPushO,iPush10,iPush5 : in std_logic;
	--	Sw15,Sw2 : in std_logic;
	--	SwRe15,SwRe2 : in std_logic;
	--	oLED : out std_logic_vector(4 downto 0);
	--	oBuzz : out std_logic;
	--	oData : out std_logic_vector(3 downto 0);
	--	dp : out std_logic;
	--	com : out std_logic_vector(3 downto 0)
	--);
	--End Component TimeTop;
	
	--Component ScoreTop is
	--Port(
	--	CLK,Rstb : in std_logic;
	--	iPush1,iPush2,iPush3 : in std_logic;
	--	Change : in std_logic;
	--	oLEDT1 : out std_logic_vector(3 downto 0);
	--	oLEDT2 : out std_logic_vector(3 downto 0);
	--	oData : out std_logic_vector(3 downto 0);
	--	com : out std_logic_vector(3 downto 0)
	--);
	--End Component ScoreTop;
	
	signal w1ms : std_logic;
	signal wPush1,wPush2,wPush3,wPush4 : std_logic;
	
Begin

	u_CLK1ms : CLK1ms
	Port Map(
		CLK	=> CLK,
		Rstb	=> Rstb,
		o1ms	=> w1ms
	);
	
	u_Push1 : Debouce
	Port Map(
		CLK	=> CLK,
		Rstb	=> Rstb,
		i1ms	=> w1ms,
		I		=> iPush1,
		O		=> wPush1
	);
	
	u_Push2 : Debouce
	Port Map(
		CLK	=> CLK,
		Rstb	=> Rstb,
		i1ms	=> w1ms,
		I		=> iPush2,
		O		=> wPush2
	);
	
	u_Push3 : Debouce
	Port Map(
		CLK	=> CLK,
		Rstb	=> Rstb,
		i1ms	=> w1ms,
		I		=> iPush3,
		O		=> wPush3
	);
	
	u_Push4 : Debouce
	Port Map(
		CLK	=> CLK,
		Rstb	=> Rstb,
		i1ms	=> w1ms,
		I		=> iPush4,
		O		=> wPush4
	);
	
	--u_TimeTop : TimeTop
	--Port Map(
	--	CLK		=> CLK,
	--	Rstb		=> Rstb,
	--	iPushS	=> ,
	--	iPushO	=> ,
	--	iPush10	=> ,
	--	iPush5	=> ,
	--	Sw15		=> ,
	--	Sw2		=> ,
	--	SwRe15	=> ,
	--	SwRe2		=> ,
	--	oLED		=> ,
	--	oBuzz		=> ,
	--	oData		=> ,
	--	dp			=> ,
	--	com		=> 
	--);
	
	--u_ScoreTop : ScoreTop
	--Port Map(
	--	CLK		=> CLK,
	--	Rstb		=> Rstb,
	--	iPush1	=> ,
	--	iPush2	=> ,
	--	iPush3	=> ,
	--	Change	=> ,
	--	oLEDT1	=> ,
	--	oLEDT2	=> ,
	--	oData		=> ,
	--	com		=> 
	--);

End Structural;

