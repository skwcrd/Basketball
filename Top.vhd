Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

Entity Top is
Port(
	CLK,Rstb : in std_logic;
	iPush1,iPush2,iPush3,iPush4 : in std_logic;
	Sw1,Sw2,Sw3,Sw4 : in std_logic;
	Change : in std_logic;
	oBuzz : out std_logic;
	oLED : out std_logic_vector(7 downto 0);
	oBCD : out std_logic_vector(6 downto 0);
	com : out std_logic_vector(3 downto 0);
	dp : out std_logic
);
End Top;

Architecture Structural of Top is
	
	Component CLK1ms is
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
	
	Component BCD is
	Port(
		I : in std_logic_vector(3 downto 0);
		O : out std_logic_vector(6 downto 0)
	);
	End Component BCD;
	
	Component FSM_top is
	Port(
		CLK,Rstb : in std_logic;
		I : in std_logic;
		iPush1,iPush2,iPush3,iPush4 : in std_logic;
		iDataTime,iDataScore : in std_logic_vector(3 downto 0);
		iComTime,iComScore : in std_logic_vector(3 downto 0);
		idp : in std_logic;
		iLEDtime,iLEDscore : in std_logic_vector(7 downto 0);
		oPush1Time,oPush2Time,oPush3Time,oPush4Time : out std_logic;
		oPush1Score,oPush2Score,oPush3Score,oPush4Score : out std_logic;
		oLED : out std_logic_vector(7 downto 0);
		oData : out std_logic_vector(3 downto 0);
		com : out std_logic_vector(3 downto 0);
		dp : out std_logic
	);
	End Component FSM_top;
	
	Component TimeTop is
	Port(
		CLK,Rstb : in std_logic;
		iPushS,iPushO,iPush10,iPush5 : in std_logic;
		Sw15,Sw2 : in std_logic;
		SwRe15,SwRe2 : in std_logic;
		oLED : out std_logic_vector(4 downto 0);
		oBuzz : out std_logic;
		oData : out std_logic_vector(3 downto 0);
		dp : out std_logic;
		com : out std_logic_vector(3 downto 0)
	);
	End Component TimeTop;
	
	Component ScoreTop is
	Port(
		CLK,Rstb : in std_logic;
		iPush1,iPush2,iPush3 : in std_logic;
		Change : in std_logic;
		oLEDT1 : out std_logic_vector(3 downto 0);
		oLEDT2 : out std_logic_vector(3 downto 0);
		oData : out std_logic_vector(3 downto 0);
		com : out std_logic_vector(3 downto 0)
	);
	End Component ScoreTop;
	
	signal w1ms : std_logic;
	signal wPush1,wPush2,wPush3,wPush4 : std_logic;
	signal wPush1Time,wPush2Time,wPush3Time,wPush4Time : std_logic;
	signal wPush1Score,wPush2Score,wPush3Score,wPush4Score : std_logic;
	signal wLEDT1,wLEDT2 : std_logic_vector(3 downto 0);
	signal wLED : std_logic_vector(4 downto 0);
	signal wLED1,wLED2 : std_logic_vector(7 downto 0);
	signal wData,wData1,wData2 : std_logic_vector(3 downto 0);
	signal wCom1,wCom2 : std_logic_vector(3 downto 0);
	signal wdp : std_logic;
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
	
	u_TimeTop : TimeTop
	Port Map(
		CLK		=> CLK,
		Rstb		=> Rstb,
		iPushS	=> wPush2Time,
		iPushO	=> wPush3Time,
		iPush10	=> wPush1Time,
		iPush5	=> wPush4Time,
		Sw15		=> Sw1,
		Sw2		=> Sw2,
		SwRe15	=> Sw3,
		SwRe2		=> Sw4,
		oLED		=> wLED,
		oBuzz		=> oBuzz,
		oData		=> wData1,
		dp			=> wdp,
		com		=> wCom1
	);
	
	u_ScoreTop : ScoreTop
	Port Map(
		CLK		=> CLK,
		Rstb		=> Rstb,
		iPush1	=> wPush1Score,
		iPush2	=> wPush2Score,
		iPush3	=> wPush3Score,
		Change	=> wPush4Score,
		oLEDT1	=> wLEDT1,
		oLEDT2	=> wLEDT2,
		oData		=> wData2,
		com		=> wCom2
	);
	
	wLED1 <= "000" & wLED;
	wLED2 <= wLEDT1 & wLEDT2;
	
	u_FSMtop : FSM_top
	Port Map(
		CLK			=> CLK,
		Rstb			=> Rstb,
		I				=> Change,
		iPush1		=> wPush1,
		iPush2		=> wPush2,
		iPush3		=> wPush3,
		iPush4		=> wPush4,
		iDataTime	=> wData1,
		iDataScore	=> wData2,
		iComTime		=> wCom1,
		iComScore	=> wCom2,
		idp			=> wdp,
		iLEDtime		=> wLED1,
		iLEDscore	=> wLED2,
		oPush1Time	=> wPush1Time,
		oPush2Time	=> wPush2Time,
		oPush3Time	=> wPush3Time,
		oPush4Time	=> wPush4Time,
		oPush1Score	=> wPush1Score,
		oPush2Score	=> wPush2Score,
		oPush3Score	=> wPush3Score,
		oPush4Score	=> wPush4Score,
		oLED			=> oLED,
		oData			=> wData,
		com			=> com,
		dp				=> dp
	);
	
	u_BCD : BCD
	Port Map(
		I	=> wData,
		O	=> oBCD
	);

End Structural;

