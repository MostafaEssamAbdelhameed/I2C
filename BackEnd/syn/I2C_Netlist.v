/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Thu Oct  5 22:00:15 2023
/////////////////////////////////////////////////////////////


module I2C_controller_DW01_inc_0 ( A, SUM );
  input [15:0] A;
  output [15:0] SUM;

  wire   [15:2] carry;

  ADDHX1M U1_1_14 ( .A(A[14]), .B(carry[14]), .CO(carry[15]), .S(SUM[14]) );
  ADDHX1M U1_1_13 ( .A(A[13]), .B(carry[13]), .CO(carry[14]), .S(SUM[13]) );
  ADDHX1M U1_1_12 ( .A(A[12]), .B(carry[12]), .CO(carry[13]), .S(SUM[12]) );
  ADDHX1M U1_1_11 ( .A(A[11]), .B(carry[11]), .CO(carry[12]), .S(SUM[11]) );
  ADDHX1M U1_1_10 ( .A(A[10]), .B(carry[10]), .CO(carry[11]), .S(SUM[10]) );
  ADDHX1M U1_1_9 ( .A(A[9]), .B(carry[9]), .CO(carry[10]), .S(SUM[9]) );
  ADDHX1M U1_1_8 ( .A(A[8]), .B(carry[8]), .CO(carry[9]), .S(SUM[8]) );
  ADDHX1M U1_1_7 ( .A(A[7]), .B(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  ADDHX1M U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHX1M U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHX1M U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHX1M U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHX1M U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHX1M U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  INVX2M U1 ( .A(A[0]), .Y(SUM[0]) );
  CLKXOR2X2M U2 ( .A(carry[15]), .B(A[15]), .Y(SUM[15]) );
endmodule


module I2C_controller ( clk, rst, wr_i2c, cmd, data_in, dvsr, data_out, ack, 
        ready, done_tick, sda_input_s, sda_output_m, scl );
  input [2:0] cmd;
  input [7:0] data_in;
  input [15:0] dvsr;
  output [7:0] data_out;
  input clk, rst, wr_i2c, sda_input_s;
  output ack, ready, done_tick, sda_output_m, scl;
  wire   scl_reg, sda_reg, N98, N99, N100, N101, N102, N103, N104, N105, N106,
         N107, N108, N109, N110, N111, N112, N113, N167, N168, N169, N170,
         N171, N172, N173, N174, N175, N176, N177, N178, N179, N180, N181,
         N182, N394, N395, N396, N397, N398, N399, N400, N401, N402, N473,
         N475, N476, N479, N480, N481, N482, N483, N484, N485, N486, N487,
         N488, N489, N490, N491, N492, N493, N494, N517, N518, N519, N520,
         N521, N522, N523, N524, N525, N526, N527, N528, N529, N530, N531,
         n117, n118, n119, n120, n121, n122, n123, n124, n125, n126, n127,
         n128, n129, n130, n131, n132, n133, n134, n135, n136, n137, n138,
         n139, n140, n141, n142, n143, n144, n145, n146, n147, n148, n149,
         n150, n151, n152, n391, n392, n393, n394, n395, n396, n397, n398,
         n399, n400, n401, n402, n403, n404, n405, n406, n407, n408, n409,
         n410, n411, n412, n413, n414, n415, n416, n417, n418, n419, n420,
         n421, n422, n423, n424, n425, n426, n427, n428, n429, n430, n431,
         n432, n433, n434, n435, n436, n437, n438, n439, n440, n441, n442,
         n443, n444, n445, n446, n447, n448, n449, n450, n451, n452, n453,
         n454, n455, n456, n457, n458, n459, n460, n461, n462, n463, n464,
         n465, n466, n467, n468, n469, n470, n471, n472, n473, n474, n475,
         n476, n477, n478, n479, n480, n481, n482, n483, n484, n485, n486,
         n487, n488, n489, n490, n491, n492, n493, n494, n495, n496, n497,
         n498, n499, n500, n501, n502, n503, n504, n505, n506, n507, n508,
         n509, n510, n511, n512, n513, n514, n515, n516, n517, n518, n519,
         n520, n521, n522, n523, n524, n525, n526, n527, n528, n529, n530,
         n531, n532, n533, n534, n535, n536, n537, n538, n539, n540, n541,
         n542, n543, n544, n545, n546, n547, n548, n549, n550, n551, n552,
         n553, n554, n555, n556, n557, n558, n559, n560, n561, n562, n563,
         n564, n565, n566, n567, n568, n569, n570, n571, n572, n573, n574,
         n575, n576, n577, n578, n579, n580, n581, n582, n583, n584, n585,
         n586, n587, n588, n589, n590, n591, n592, n593, n594, n595, n596,
         n597, n598, n599, n600, n601, n602, n603, n604, n605, n606, n607,
         n608, n609, n610, n611, n612, n613, n614, n615, n616, n617, n618,
         n619, n620, n621, n622, n623, n624, n625, n626, n627, n628, n629,
         n630, n631, n632, n633, n634, n635, n636, n637, n638, n639, n640,
         n641, n642, n643, n644, n645, n646, n647;
  wire   [3:0] bits_count;
  wire   [3:0] current_state;
  wire   [15:0] counter;
  wire   [3:0] N_bits;
  wire   [8:0] RX_reg;
  wire   [8:0] TX_reg;
  wire   [3:0] next_state;
  wire   [15:0] count_reg;
  wire   [8:1] RX;
  tri   sda_output_m;
  assign scl = scl_reg;

  I2C_controller_DW01_inc_0 add_74 ( .A(count_reg), .SUM({N113, N112, N111, 
        N110, N109, N108, N107, N106, N105, N104, N103, N102, N101, N100, N99, 
        N98}) );
  TBUFX2M sda_output_m_tri ( .A(sda_reg), .OE(n117), .Y(sda_output_m) );
  DFFSQX2M scl_reg_reg ( .D(n143), .CK(clk), .SN(rst), .Q(scl_reg) );
  DFFRX1M \RX_reg_reg[8]  ( .D(RX[8]), .CK(clk), .RN(rst), .Q(RX_reg[8]), .QN(
        n135) );
  DFFRX1M \RX_reg_reg[7]  ( .D(RX[7]), .CK(clk), .RN(rst), .Q(RX_reg[7]), .QN(
        n136) );
  DFFRX1M \RX_reg_reg[6]  ( .D(RX[6]), .CK(clk), .RN(rst), .Q(RX_reg[6]), .QN(
        n137) );
  DFFRX1M \RX_reg_reg[5]  ( .D(RX[5]), .CK(clk), .RN(rst), .Q(RX_reg[5]), .QN(
        n138) );
  DFFRX1M \RX_reg_reg[4]  ( .D(RX[4]), .CK(clk), .RN(rst), .Q(RX_reg[4]), .QN(
        n139) );
  DFFRX1M \RX_reg_reg[3]  ( .D(RX[3]), .CK(clk), .RN(rst), .Q(RX_reg[3]), .QN(
        n140) );
  DFFRX1M \RX_reg_reg[2]  ( .D(RX[2]), .CK(clk), .RN(rst), .Q(RX_reg[2]), .QN(
        n141) );
  DFFRX1M \RX_reg_reg[1]  ( .D(RX[1]), .CK(clk), .RN(rst), .Q(RX_reg[1]), .QN(
        n142) );
  DFFRX1M \RX_reg_reg[0]  ( .D(ack), .CK(clk), .RN(rst), .Q(RX_reg[0]), .QN(
        n646) );
  DFFRQX2M \TX_reg_reg[1]  ( .D(n152), .CK(clk), .RN(rst), .Q(TX_reg[1]) );
  DFFRQX2M \TX_reg_reg[2]  ( .D(n151), .CK(clk), .RN(rst), .Q(TX_reg[2]) );
  DFFRQX2M \TX_reg_reg[3]  ( .D(n150), .CK(clk), .RN(rst), .Q(TX_reg[3]) );
  DFFRQX2M \TX_reg_reg[4]  ( .D(n149), .CK(clk), .RN(rst), .Q(TX_reg[4]) );
  DFFRQX2M \TX_reg_reg[5]  ( .D(n148), .CK(clk), .RN(rst), .Q(TX_reg[5]) );
  DFFRQX2M \TX_reg_reg[6]  ( .D(n147), .CK(clk), .RN(rst), .Q(TX_reg[6]) );
  DFFRQX2M \TX_reg_reg[7]  ( .D(n146), .CK(clk), .RN(rst), .Q(TX_reg[7]) );
  DFFRQX2M \TX_reg_reg[8]  ( .D(n145), .CK(clk), .RN(rst), .Q(TX_reg[8]) );
  DFFRX1M \counter_reg[15]  ( .D(N113), .CK(clk), .RN(rst), .Q(counter[15]), 
        .QN(n118) );
  DFFRX1M \counter_reg[14]  ( .D(N112), .CK(clk), .RN(rst), .Q(counter[14]), 
        .QN(n120) );
  DFFRX1M \counter_reg[13]  ( .D(N111), .CK(clk), .RN(rst), .Q(counter[13]), 
        .QN(n121) );
  DFFRX1M \counter_reg[12]  ( .D(N110), .CK(clk), .RN(rst), .Q(counter[12]), 
        .QN(n122) );
  DFFRX1M \counter_reg[11]  ( .D(N109), .CK(clk), .RN(rst), .Q(counter[11]), 
        .QN(n123) );
  DFFRX1M \counter_reg[10]  ( .D(N108), .CK(clk), .RN(rst), .Q(counter[10]), 
        .QN(n124) );
  DFFRX1M \counter_reg[9]  ( .D(N107), .CK(clk), .RN(rst), .Q(counter[9]), 
        .QN(n125) );
  DFFRX1M \counter_reg[8]  ( .D(N106), .CK(clk), .RN(rst), .Q(counter[8]), 
        .QN(n126) );
  DFFRX1M \counter_reg[7]  ( .D(N105), .CK(clk), .RN(rst), .Q(counter[7]), 
        .QN(n127) );
  DFFRX1M \counter_reg[6]  ( .D(N104), .CK(clk), .RN(rst), .Q(counter[6]), 
        .QN(n128) );
  DFFRX1M \counter_reg[5]  ( .D(N103), .CK(clk), .RN(rst), .Q(counter[5]), 
        .QN(n129) );
  DFFRX1M \counter_reg[4]  ( .D(N102), .CK(clk), .RN(rst), .Q(counter[4]), 
        .QN(n130) );
  DFFRX1M \counter_reg[3]  ( .D(N101), .CK(clk), .RN(rst), .Q(counter[3]), 
        .QN(n131) );
  DFFRX1M \counter_reg[2]  ( .D(N100), .CK(clk), .RN(rst), .Q(counter[2]), 
        .QN(n132) );
  DFFRX1M \counter_reg[1]  ( .D(N99), .CK(clk), .RN(rst), .Q(counter[1]), .QN(
        n133) );
  DFFRX1M \counter_reg[0]  ( .D(N98), .CK(clk), .RN(rst), .Q(counter[0]), .QN(
        n134) );
  DFFRQX2M \N_bits_reg[3]  ( .D(bits_count[3]), .CK(clk), .RN(rst), .Q(
        N_bits[3]) );
  DFFRQX2M \current_state_reg[0]  ( .D(next_state[0]), .CK(clk), .RN(rst), .Q(
        current_state[0]) );
  DFFRQX2M \N_bits_reg[0]  ( .D(bits_count[0]), .CK(clk), .RN(rst), .Q(
        N_bits[0]) );
  DFFRQX2M sda_reg_reg ( .D(n144), .CK(clk), .RN(rst), .Q(sda_reg) );
  DFFRQX2M \N_bits_reg[2]  ( .D(bits_count[2]), .CK(clk), .RN(rst), .Q(
        N_bits[2]) );
  DFFRQX2M \N_bits_reg[1]  ( .D(bits_count[1]), .CK(clk), .RN(rst), .Q(
        N_bits[1]) );
  DFFRQX2M \current_state_reg[3]  ( .D(next_state[3]), .CK(clk), .RN(rst), .Q(
        current_state[3]) );
  DFFRQX4M \current_state_reg[2]  ( .D(next_state[2]), .CK(clk), .RN(rst), .Q(
        current_state[2]) );
  DFFRQX4M \current_state_reg[1]  ( .D(next_state[1]), .CK(clk), .RN(rst), .Q(
        current_state[1]) );
  INVX4M U435 ( .A(current_state[0]), .Y(n647) );
  NOR3BX2M U436 ( .AN(wr_i2c), .B(n555), .C(cmd[2]), .Y(n532) );
  INVXLM U437 ( .A(n647), .Y(n498) );
  INVXLM U438 ( .A(n647), .Y(n500) );
  INVXLM U439 ( .A(n647), .Y(n501) );
  INVXLM U440 ( .A(n647), .Y(n496) );
  INVXLM U441 ( .A(n647), .Y(n494) );
  INVXLM U442 ( .A(n647), .Y(n492) );
  INVXLM U443 ( .A(n647), .Y(n490) );
  INVXLM U444 ( .A(n647), .Y(n488) );
  INVXLM U445 ( .A(n647), .Y(n486) );
  INVXLM U446 ( .A(n647), .Y(n484) );
  INVXLM U447 ( .A(n647), .Y(n482) );
  INVXLM U448 ( .A(n647), .Y(n480) );
  INVXLM U449 ( .A(n647), .Y(n478) );
  INVXLM U450 ( .A(n647), .Y(n477) );
  INVXLM U451 ( .A(n647), .Y(n476) );
  INVXLM U452 ( .A(n647), .Y(n475) );
  INVXLM U453 ( .A(n647), .Y(n474) );
  INVXLM U454 ( .A(n647), .Y(n497) );
  INVXLM U455 ( .A(n647), .Y(n499) );
  INVXLM U456 ( .A(n647), .Y(n495) );
  INVXLM U457 ( .A(n647), .Y(n493) );
  INVXLM U458 ( .A(n647), .Y(n491) );
  INVXLM U459 ( .A(n647), .Y(n489) );
  INVXLM U460 ( .A(n647), .Y(n487) );
  INVXLM U461 ( .A(n647), .Y(n485) );
  INVXLM U462 ( .A(n647), .Y(n483) );
  INVXLM U463 ( .A(n647), .Y(n481) );
  INVXLM U464 ( .A(n647), .Y(n479) );
  INVXLM U465 ( .A(n647), .Y(n473) );
  AND2X1M U466 ( .A(N517), .B(n647), .Y(n409) );
  AND2X1M U467 ( .A(counter[0]), .B(n647), .Y(n405) );
  AND2X1M U468 ( .A(N518), .B(n647), .Y(n413) );
  AND2X1M U469 ( .A(N519), .B(n647), .Y(n417) );
  AND2X1M U470 ( .A(N520), .B(n647), .Y(n421) );
  AND2X1M U471 ( .A(N521), .B(n647), .Y(n425) );
  AND2X1M U472 ( .A(N522), .B(n647), .Y(n429) );
  AND2X1M U473 ( .A(N523), .B(n647), .Y(n433) );
  AND2X1M U474 ( .A(N524), .B(n647), .Y(n437) );
  AND2X1M U475 ( .A(N525), .B(n647), .Y(n441) );
  AND2X1M U476 ( .A(N526), .B(n647), .Y(n445) );
  AND2X1M U477 ( .A(N527), .B(n647), .Y(n449) );
  AND2X1M U478 ( .A(N528), .B(n647), .Y(n453) );
  AND2X1M U479 ( .A(N529), .B(n647), .Y(n457) );
  AND2X1M U480 ( .A(N530), .B(n647), .Y(n461) );
  AND2X1M U481 ( .A(N531), .B(n647), .Y(n465) );
  NOR2XLM U482 ( .A(n647), .B(n391), .Y(n392) );
  XNOR2X2M U483 ( .A(current_state[3]), .B(current_state[1]), .Y(n391) );
  OR2X1M U484 ( .A(current_state[3]), .B(n647), .Y(n468) );
  MX4X1M U485 ( .A(n406), .B(n403), .C(n404), .D(counter[0]), .S0(
        current_state[2]), .S1(current_state[3]), .Y(count_reg[0]) );
  MX3XLM U486 ( .A(N167), .B(counter[0]), .C(n405), .S0(n499), .S1(
        current_state[1]), .Y(n406) );
  MX4XLM U487 ( .A(counter[0]), .B(counter[0]), .C(N479), .D(N479), .S0(n501), 
        .S1(current_state[1]), .Y(n403) );
  MX4XLM U488 ( .A(N479), .B(N479), .C(N479), .D(counter[0]), .S0(n500), .S1(
        current_state[1]), .Y(n404) );
  MX2X2M U489 ( .A(n556), .B(n468), .S0(current_state[2]), .Y(n396) );
  INVX2M U490 ( .A(n467), .Y(n471) );
  NAND4BX1M U491 ( .AN(current_state[3]), .B(n497), .C(current_state[2]), .D(
        current_state[1]), .Y(n467) );
  MX4X1M U492 ( .A(N480), .B(N480), .C(counter[1]), .D(N480), .S0(n647), .S1(
        current_state[1]), .Y(n408) );
  MX4X1M U493 ( .A(N481), .B(N481), .C(counter[2]), .D(N481), .S0(n647), .S1(
        current_state[1]), .Y(n412) );
  MX4X1M U494 ( .A(N482), .B(N482), .C(counter[3]), .D(N482), .S0(n647), .S1(
        current_state[1]), .Y(n416) );
  MX4X1M U495 ( .A(N483), .B(N483), .C(counter[4]), .D(N483), .S0(n647), .S1(
        current_state[1]), .Y(n420) );
  MX4X1M U496 ( .A(N484), .B(N484), .C(counter[5]), .D(N484), .S0(n647), .S1(
        current_state[1]), .Y(n424) );
  MX4X1M U497 ( .A(N485), .B(N485), .C(counter[6]), .D(N485), .S0(n647), .S1(
        current_state[1]), .Y(n428) );
  MX4X1M U498 ( .A(N486), .B(N486), .C(counter[7]), .D(N486), .S0(n647), .S1(
        current_state[1]), .Y(n432) );
  MX4X1M U499 ( .A(N487), .B(N487), .C(counter[8]), .D(N487), .S0(n647), .S1(
        current_state[1]), .Y(n436) );
  MX4X1M U500 ( .A(N488), .B(N488), .C(counter[9]), .D(N488), .S0(n647), .S1(
        current_state[1]), .Y(n440) );
  MX4X1M U501 ( .A(N489), .B(N489), .C(counter[10]), .D(N489), .S0(n647), .S1(
        current_state[1]), .Y(n444) );
  MX4X1M U502 ( .A(N490), .B(N490), .C(counter[11]), .D(N490), .S0(n647), .S1(
        current_state[1]), .Y(n448) );
  MX4X1M U503 ( .A(N491), .B(N491), .C(counter[12]), .D(N491), .S0(n647), .S1(
        current_state[1]), .Y(n452) );
  MX4X1M U504 ( .A(N492), .B(N492), .C(counter[13]), .D(N492), .S0(n647), .S1(
        current_state[1]), .Y(n456) );
  MX4X1M U505 ( .A(N493), .B(N493), .C(counter[14]), .D(N493), .S0(n647), .S1(
        current_state[1]), .Y(n460) );
  MX4X1M U506 ( .A(N494), .B(N494), .C(counter[15]), .D(N494), .S0(n647), .S1(
        current_state[1]), .Y(n464) );
  MX2X2M U507 ( .A(N_bits[3]), .B(n401), .S0(n472), .Y(bits_count[3]) );
  AND2X2M U508 ( .A(n402), .B(n396), .Y(n401) );
  MX2X2M U509 ( .A(N476), .B(N_bits[3]), .S0(current_state[2]), .Y(n402) );
  MX2X2M U510 ( .A(N_bits[2]), .B(n399), .S0(n472), .Y(bits_count[2]) );
  AND2X2M U511 ( .A(n400), .B(n396), .Y(n399) );
  MX2X2M U512 ( .A(N475), .B(N_bits[2]), .S0(current_state[2]), .Y(n400) );
  MX2X2M U513 ( .A(N_bits[0]), .B(n394), .S0(n393), .Y(bits_count[0]) );
  AND2X2M U514 ( .A(n395), .B(n396), .Y(n394) );
  MX2XLM U515 ( .A(n392), .B(n556), .S0(current_state[2]), .Y(n393) );
  MX2X2M U516 ( .A(N473), .B(N_bits[0]), .S0(current_state[2]), .Y(n395) );
  MX2X2M U517 ( .A(N_bits[1]), .B(n397), .S0(n472), .Y(bits_count[1]) );
  AND2X2M U518 ( .A(n398), .B(n396), .Y(n397) );
  MX2X2M U519 ( .A(n119), .B(N_bits[1]), .S0(current_state[2]), .Y(n398) );
  MX2X2M U520 ( .A(RX_reg[1]), .B(N395), .S0(n471), .Y(RX[1]) );
  MX2X2M U521 ( .A(RX_reg[2]), .B(N396), .S0(n471), .Y(RX[2]) );
  MX2X2M U522 ( .A(RX_reg[3]), .B(N397), .S0(n471), .Y(RX[3]) );
  MX2X2M U523 ( .A(RX_reg[4]), .B(N398), .S0(n471), .Y(RX[4]) );
  MX2X2M U524 ( .A(RX_reg[5]), .B(N399), .S0(n471), .Y(RX[5]) );
  MX2X2M U525 ( .A(RX_reg[6]), .B(N400), .S0(n471), .Y(RX[6]) );
  MX2X2M U526 ( .A(RX_reg[7]), .B(N401), .S0(n471), .Y(RX[7]) );
  MX2X2M U527 ( .A(RX_reg[8]), .B(N402), .S0(n471), .Y(RX[8]) );
  MX2X2M U528 ( .A(RX_reg[0]), .B(N394), .S0(n471), .Y(ack) );
  MX4X1M U529 ( .A(n466), .B(n463), .C(n464), .D(counter[15]), .S0(
        current_state[2]), .S1(current_state[3]), .Y(count_reg[15]) );
  MX3XLM U530 ( .A(N182), .B(N531), .C(n465), .S0(n473), .S1(current_state[1]), 
        .Y(n466) );
  MX4XLM U531 ( .A(N531), .B(N531), .C(N494), .D(N494), .S0(n474), .S1(
        current_state[1]), .Y(n463) );
  MX4X1M U532 ( .A(n410), .B(n407), .C(n408), .D(counter[1]), .S0(
        current_state[2]), .S1(current_state[3]), .Y(count_reg[1]) );
  MX3XLM U533 ( .A(N168), .B(N517), .C(n409), .S0(n497), .S1(current_state[1]), 
        .Y(n410) );
  MX4XLM U534 ( .A(N517), .B(N517), .C(N480), .D(N480), .S0(n498), .S1(
        current_state[1]), .Y(n407) );
  MX4X1M U535 ( .A(n414), .B(n411), .C(n412), .D(counter[2]), .S0(
        current_state[2]), .S1(current_state[3]), .Y(count_reg[2]) );
  MX3XLM U536 ( .A(N169), .B(N518), .C(n413), .S0(n495), .S1(current_state[1]), 
        .Y(n414) );
  MX4XLM U537 ( .A(N518), .B(N518), .C(N481), .D(N481), .S0(n496), .S1(
        current_state[1]), .Y(n411) );
  MX4X1M U538 ( .A(n418), .B(n415), .C(n416), .D(counter[3]), .S0(
        current_state[2]), .S1(current_state[3]), .Y(count_reg[3]) );
  MX3XLM U539 ( .A(N170), .B(N519), .C(n417), .S0(n493), .S1(current_state[1]), 
        .Y(n418) );
  MX4XLM U540 ( .A(N519), .B(N519), .C(N482), .D(N482), .S0(n494), .S1(
        current_state[1]), .Y(n415) );
  MX4X1M U541 ( .A(n422), .B(n419), .C(n420), .D(counter[4]), .S0(
        current_state[2]), .S1(current_state[3]), .Y(count_reg[4]) );
  MX3XLM U542 ( .A(N171), .B(N520), .C(n421), .S0(n491), .S1(current_state[1]), 
        .Y(n422) );
  MX4XLM U543 ( .A(N520), .B(N520), .C(N483), .D(N483), .S0(n492), .S1(
        current_state[1]), .Y(n419) );
  MX4X1M U544 ( .A(n426), .B(n423), .C(n424), .D(counter[5]), .S0(
        current_state[2]), .S1(current_state[3]), .Y(count_reg[5]) );
  MX3XLM U545 ( .A(N172), .B(N521), .C(n425), .S0(n489), .S1(current_state[1]), 
        .Y(n426) );
  MX4XLM U546 ( .A(N521), .B(N521), .C(N484), .D(N484), .S0(n490), .S1(
        current_state[1]), .Y(n423) );
  MX4X1M U547 ( .A(n430), .B(n427), .C(n428), .D(counter[6]), .S0(
        current_state[2]), .S1(current_state[3]), .Y(count_reg[6]) );
  MX3XLM U548 ( .A(N173), .B(N522), .C(n429), .S0(n487), .S1(current_state[1]), 
        .Y(n430) );
  MX4XLM U549 ( .A(N522), .B(N522), .C(N485), .D(N485), .S0(n488), .S1(
        current_state[1]), .Y(n427) );
  MX4X1M U550 ( .A(n434), .B(n431), .C(n432), .D(counter[7]), .S0(
        current_state[2]), .S1(current_state[3]), .Y(count_reg[7]) );
  MX3XLM U551 ( .A(N174), .B(N523), .C(n433), .S0(n485), .S1(current_state[1]), 
        .Y(n434) );
  MX4XLM U552 ( .A(N523), .B(N523), .C(N486), .D(N486), .S0(n486), .S1(
        current_state[1]), .Y(n431) );
  MX4X1M U553 ( .A(n438), .B(n435), .C(n436), .D(counter[8]), .S0(
        current_state[2]), .S1(current_state[3]), .Y(count_reg[8]) );
  MX3XLM U554 ( .A(N175), .B(N524), .C(n437), .S0(n483), .S1(current_state[1]), 
        .Y(n438) );
  MX4XLM U555 ( .A(N524), .B(N524), .C(N487), .D(N487), .S0(n484), .S1(
        current_state[1]), .Y(n435) );
  MX4X1M U556 ( .A(n442), .B(n439), .C(n440), .D(counter[9]), .S0(
        current_state[2]), .S1(current_state[3]), .Y(count_reg[9]) );
  MX3XLM U557 ( .A(N176), .B(N525), .C(n441), .S0(n481), .S1(current_state[1]), 
        .Y(n442) );
  MX4XLM U558 ( .A(N525), .B(N525), .C(N488), .D(N488), .S0(n482), .S1(
        current_state[1]), .Y(n439) );
  MX4X1M U559 ( .A(n446), .B(n443), .C(n444), .D(counter[10]), .S0(
        current_state[2]), .S1(current_state[3]), .Y(count_reg[10]) );
  MX3XLM U560 ( .A(N177), .B(N526), .C(n445), .S0(n479), .S1(current_state[1]), 
        .Y(n446) );
  MX4XLM U561 ( .A(N526), .B(N526), .C(N489), .D(N489), .S0(n480), .S1(
        current_state[1]), .Y(n443) );
  MX4X1M U562 ( .A(n450), .B(n447), .C(n448), .D(counter[11]), .S0(
        current_state[2]), .S1(current_state[3]), .Y(count_reg[11]) );
  MX3XLM U563 ( .A(N178), .B(N527), .C(n449), .S0(n491), .S1(current_state[1]), 
        .Y(n450) );
  MX4XLM U564 ( .A(N527), .B(N527), .C(N490), .D(N490), .S0(n478), .S1(
        current_state[1]), .Y(n447) );
  MX4X1M U565 ( .A(n454), .B(n451), .C(n452), .D(counter[12]), .S0(
        current_state[2]), .S1(current_state[3]), .Y(count_reg[12]) );
  MX3XLM U566 ( .A(N179), .B(N528), .C(n453), .S0(n493), .S1(current_state[1]), 
        .Y(n454) );
  MX4XLM U567 ( .A(N528), .B(N528), .C(N491), .D(N491), .S0(n477), .S1(
        current_state[1]), .Y(n451) );
  MX4X1M U568 ( .A(n458), .B(n455), .C(n456), .D(counter[13]), .S0(
        current_state[2]), .S1(current_state[3]), .Y(count_reg[13]) );
  MX3XLM U569 ( .A(N180), .B(N529), .C(n457), .S0(n495), .S1(current_state[1]), 
        .Y(n458) );
  MX4XLM U570 ( .A(N529), .B(N529), .C(N492), .D(N492), .S0(n476), .S1(
        current_state[1]), .Y(n455) );
  INVX2M U571 ( .A(n470), .Y(n472) );
  MX3X1M U572 ( .A(n469), .B(n468), .C(current_state[1]), .S0(current_state[1]), .S1(current_state[2]), .Y(n470) );
  OR2X1M U573 ( .A(n647), .B(n560), .Y(n469) );
  MX4X1M U574 ( .A(n462), .B(n459), .C(n460), .D(counter[14]), .S0(
        current_state[2]), .S1(current_state[3]), .Y(count_reg[14]) );
  MX3XLM U575 ( .A(N181), .B(N530), .C(n461), .S0(n499), .S1(current_state[1]), 
        .Y(n462) );
  MX4XLM U576 ( .A(N530), .B(N530), .C(N493), .D(N493), .S0(n475), .S1(
        current_state[1]), .Y(n459) );
  CLKINVX1M U577 ( .A(n502), .Y(ready) );
  NAND3BX1M U578 ( .AN(n503), .B(n504), .C(n505), .Y(next_state[3]) );
  MXI2X1M U579 ( .A(n506), .B(n507), .S0(n508), .Y(n505) );
  OAI211X1M U580 ( .A0(n509), .A1(n510), .B0(n511), .C0(n512), .Y(
        next_state[2]) );
  AOI211X1M U581 ( .A0(n513), .A1(n514), .B0(n515), .C0(n516), .Y(n512) );
  NAND4X1M U582 ( .A(n517), .B(n518), .C(n519), .D(n520), .Y(next_state[1]) );
  NOR2BX1M U583 ( .AN(n511), .B(n521), .Y(n520) );
  OAI32X1M U584 ( .A0(n522), .A1(n523), .A2(n524), .B0(n508), .B1(n525), .Y(
        n521) );
  AOI221XLM U585 ( .A0(current_state[1]), .A1(n526), .B0(n508), .B1(n506), 
        .C0(n527), .Y(n511) );
  CLKINVX1M U586 ( .A(n528), .Y(n526) );
  NAND3X1M U587 ( .A(n529), .B(n530), .C(n531), .Y(next_state[0]) );
  AOI21BX1M U588 ( .A0(n532), .A1(n533), .B0N(n518), .Y(n531) );
  MXI2X1M U589 ( .A(n534), .B(n535), .S0(n522), .Y(n530) );
  CLKNAND2X2M U590 ( .A(n536), .B(n519), .Y(n534) );
  MXI2X1M U591 ( .A(n537), .B(n538), .S0(n508), .Y(n529) );
  NAND2BX1M U592 ( .AN(n539), .B(n517), .Y(n537) );
  AO2B2X1M U593 ( .B0(data_in[0]), .B1(n527), .A0(TX_reg[1]), .A1N(n540), .Y(
        n152) );
  OAI2B1X1M U594 ( .A1N(TX_reg[2]), .A0(n540), .B0(n541), .Y(n151) );
  AOI22X1M U595 ( .A0(data_in[1]), .A1(n527), .B0(n516), .B1(TX_reg[1]), .Y(
        n541) );
  OAI2B1X1M U596 ( .A1N(TX_reg[3]), .A0(n540), .B0(n542), .Y(n150) );
  AOI22X1M U597 ( .A0(data_in[2]), .A1(n527), .B0(TX_reg[2]), .B1(n516), .Y(
        n542) );
  OAI2B1X1M U598 ( .A1N(TX_reg[4]), .A0(n540), .B0(n543), .Y(n149) );
  AOI22X1M U599 ( .A0(data_in[3]), .A1(n527), .B0(TX_reg[3]), .B1(n516), .Y(
        n543) );
  OAI2B1X1M U600 ( .A1N(TX_reg[5]), .A0(n540), .B0(n544), .Y(n148) );
  AOI22X1M U601 ( .A0(data_in[4]), .A1(n527), .B0(TX_reg[4]), .B1(n516), .Y(
        n544) );
  OAI2B1X1M U602 ( .A1N(TX_reg[6]), .A0(n540), .B0(n545), .Y(n147) );
  AOI22X1M U603 ( .A0(data_in[5]), .A1(n527), .B0(TX_reg[5]), .B1(n516), .Y(
        n545) );
  OAI2B1X1M U604 ( .A1N(TX_reg[7]), .A0(n540), .B0(n546), .Y(n146) );
  AOI22X1M U605 ( .A0(data_in[6]), .A1(n527), .B0(TX_reg[6]), .B1(n516), .Y(
        n546) );
  OAI2B1X1M U606 ( .A1N(TX_reg[8]), .A0(n540), .B0(n547), .Y(n145) );
  AOI22X1M U607 ( .A0(data_in[7]), .A1(n527), .B0(TX_reg[7]), .B1(n516), .Y(
        n547) );
  NOR2BX1M U608 ( .AN(n548), .B(n525), .Y(n516) );
  NOR3BX1M U609 ( .AN(n514), .B(n549), .C(n513), .Y(n527) );
  AND4X1M U610 ( .A(n550), .B(n519), .C(n551), .D(n552), .Y(n540) );
  NOR4X1M U611 ( .A(n553), .B(n503), .C(n539), .D(n535), .Y(n552) );
  OAI21X1M U612 ( .A0(n548), .A1(n525), .B0(n518), .Y(n503) );
  CLKNAND2X2M U613 ( .A(n549), .B(n514), .Y(n518) );
  NOR2X1M U614 ( .A(n554), .B(n555), .Y(n549) );
  AOI2BB1X1M U615 ( .A0N(n513), .A1N(n533), .B0(n502), .Y(n553) );
  NOR2X1M U616 ( .A(n533), .B(n514), .Y(n502) );
  NOR3X1M U617 ( .A(n523), .B(current_state[2]), .C(n556), .Y(n514) );
  NOR3X1M U618 ( .A(n557), .B(cmd[2]), .C(n558), .Y(n513) );
  NOR3X1M U619 ( .A(n507), .B(n515), .C(n506), .Y(n551) );
  CLKINVX1M U620 ( .A(n517), .Y(n507) );
  CLKNAND2X2M U621 ( .A(n559), .B(current_state[3]), .Y(n517) );
  CLKNAND2X2M U622 ( .A(n559), .B(n560), .Y(n519) );
  NOR3X1M U623 ( .A(current_state[0]), .B(current_state[2]), .C(n556), .Y(n559) );
  NAND4X1M U624 ( .A(n561), .B(n562), .C(n563), .D(n510), .Y(n144) );
  OAI21X1M U625 ( .A0(n539), .A1(n538), .B0(TX_reg[8]), .Y(n562) );
  CLKNAND2X2M U626 ( .A(n525), .B(n564), .Y(n538) );
  OAI21X1M U627 ( .A0(n556), .A1(n528), .B0(n504), .Y(n539) );
  CLKNAND2X2M U628 ( .A(sda_reg), .B(n565), .Y(n561) );
  NAND4X1M U629 ( .A(n504), .B(n536), .C(n563), .D(n566), .Y(n143) );
  AOI211X1M U630 ( .A0(scl_reg), .A1(n565), .B0(n535), .C0(n506), .Y(n566) );
  CLKINVX1M U631 ( .A(n564), .Y(n506) );
  NAND3X1M U632 ( .A(current_state[1]), .B(n567), .C(current_state[2]), .Y(
        n564) );
  OAI21X1M U633 ( .A0(n523), .A1(n524), .B0(n510), .Y(n535) );
  NAND3X1M U634 ( .A(n567), .B(n556), .C(current_state[2]), .Y(n510) );
  CLKINVX1M U635 ( .A(current_state[1]), .Y(n556) );
  CLKINVX1M U636 ( .A(n567), .Y(n523) );
  NOR2X1M U637 ( .A(n647), .B(current_state[3]), .Y(n567) );
  CLKINVX1M U638 ( .A(n550), .Y(n565) );
  OAI211X1M U639 ( .A0(current_state[2]), .A1(current_state[0]), .B0(n524), 
        .C0(current_state[3]), .Y(n550) );
  CLKINVX1M U640 ( .A(n533), .Y(n563) );
  NOR3X1M U641 ( .A(current_state[0]), .B(current_state[3]), .C(n524), .Y(n533) );
  CLKINVX1M U642 ( .A(n568), .Y(n524) );
  CLKINVX1M U643 ( .A(n515), .Y(n536) );
  NOR2X1M U644 ( .A(n528), .B(current_state[1]), .Y(n515) );
  NAND3X1M U645 ( .A(n647), .B(n560), .C(current_state[2]), .Y(n528) );
  CLKINVX1M U646 ( .A(current_state[3]), .Y(n560) );
  NAND3X1M U647 ( .A(n568), .B(n647), .C(current_state[3]), .Y(n504) );
  CLKNAND2X2M U648 ( .A(n569), .B(n570), .Y(n119) );
  MXI2X1M U649 ( .A(N_bits[1]), .B(n571), .S0(n548), .Y(n569) );
  CLKNAND2X2M U650 ( .A(n572), .B(n573), .Y(n117) );
  CLKMX2X2M U651 ( .A(cmd[1]), .B(n574), .S0(bits_count[3]), .Y(n572) );
  NOR4X1M U652 ( .A(bits_count[2]), .B(bits_count[1]), .C(bits_count[0]), .D(
        n557), .Y(n574) );
  NOR2BX1M U653 ( .AN(RX[8]), .B(n575), .Y(data_out[7]) );
  NOR2BX1M U654 ( .AN(RX[7]), .B(n575), .Y(data_out[6]) );
  NOR2BX1M U655 ( .AN(RX[6]), .B(n575), .Y(data_out[5]) );
  NOR2BX1M U656 ( .AN(RX[5]), .B(n575), .Y(data_out[4]) );
  NOR2BX1M U657 ( .AN(RX[4]), .B(n575), .Y(data_out[3]) );
  NOR2BX1M U658 ( .AN(RX[3]), .B(n575), .Y(data_out[2]) );
  NOR2BX1M U659 ( .AN(RX[2]), .B(n575), .Y(data_out[1]) );
  NOR2BX1M U660 ( .AN(RX[1]), .B(n575), .Y(data_out[0]) );
  NAND4X1M U661 ( .A(done_tick), .B(cmd[1]), .C(n557), .D(n554), .Y(n575) );
  CLKINVX1M U662 ( .A(cmd[2]), .Y(n554) );
  NOR3X1M U663 ( .A(n525), .B(n508), .C(n576), .Y(done_tick) );
  NAND3X1M U664 ( .A(n568), .B(current_state[0]), .C(current_state[3]), .Y(
        n525) );
  NOR2X1M U665 ( .A(current_state[1]), .B(current_state[2]), .Y(n568) );
  NOR2X1M U666 ( .A(n118), .B(n509), .Y(N531) );
  NOR2X1M U667 ( .A(n120), .B(n509), .Y(N530) );
  NOR2X1M U668 ( .A(n121), .B(n509), .Y(N529) );
  NOR2X1M U669 ( .A(n122), .B(n509), .Y(N528) );
  NOR2X1M U670 ( .A(n123), .B(n509), .Y(N527) );
  NOR2X1M U671 ( .A(n124), .B(n509), .Y(N526) );
  NOR2X1M U672 ( .A(n125), .B(n509), .Y(N525) );
  NOR2X1M U673 ( .A(n126), .B(n509), .Y(N524) );
  NOR2X1M U674 ( .A(n127), .B(n509), .Y(N523) );
  NOR2X1M U675 ( .A(n128), .B(n509), .Y(N522) );
  NOR2X1M U676 ( .A(n129), .B(n509), .Y(N521) );
  NOR2X1M U677 ( .A(n130), .B(n509), .Y(N520) );
  NOR2X1M U678 ( .A(n131), .B(n509), .Y(N519) );
  NOR2X1M U679 ( .A(n132), .B(n509), .Y(N518) );
  NOR2X1M U680 ( .A(n133), .B(n509), .Y(N517) );
  CLKINVX1M U681 ( .A(n522), .Y(n509) );
  NAND4X1M U682 ( .A(n577), .B(n578), .C(n579), .D(n580), .Y(n522) );
  NOR4X1M U683 ( .A(counter[0]), .B(n581), .C(n582), .D(n583), .Y(n580) );
  XNOR2X1M U684 ( .A(dvsr[2]), .B(n131), .Y(n583) );
  XNOR2X1M U685 ( .A(dvsr[14]), .B(n118), .Y(n582) );
  XNOR2X1M U686 ( .A(dvsr[0]), .B(n133), .Y(n581) );
  NOR4X1M U687 ( .A(n584), .B(n585), .C(n586), .D(n587), .Y(n579) );
  XNOR2X1M U688 ( .A(dvsr[6]), .B(n127), .Y(n587) );
  XNOR2X1M U689 ( .A(dvsr[4]), .B(n129), .Y(n586) );
  XNOR2X1M U690 ( .A(dvsr[3]), .B(n130), .Y(n585) );
  XNOR2X1M U691 ( .A(dvsr[1]), .B(n132), .Y(n584) );
  NOR4X1M U692 ( .A(n588), .B(n589), .C(n590), .D(n591), .Y(n578) );
  XNOR2X1M U693 ( .A(dvsr[8]), .B(n125), .Y(n591) );
  XNOR2X1M U694 ( .A(dvsr[7]), .B(n126), .Y(n590) );
  XNOR2X1M U695 ( .A(dvsr[5]), .B(n128), .Y(n589) );
  XNOR2X1M U696 ( .A(dvsr[10]), .B(n123), .Y(n588) );
  NOR4X1M U697 ( .A(n592), .B(n593), .C(n594), .D(n595), .Y(n577) );
  XNOR2X1M U698 ( .A(dvsr[9]), .B(n124), .Y(n595) );
  XNOR2X1M U699 ( .A(dvsr[13]), .B(n120), .Y(n594) );
  XNOR2X1M U700 ( .A(dvsr[12]), .B(n121), .Y(n593) );
  XNOR2X1M U701 ( .A(dvsr[11]), .B(n122), .Y(n592) );
  NOR2X1M U702 ( .A(n118), .B(n596), .Y(N494) );
  NOR2X1M U703 ( .A(n120), .B(n596), .Y(N493) );
  NOR2X1M U704 ( .A(n121), .B(n596), .Y(N492) );
  NOR2X1M U705 ( .A(n122), .B(n596), .Y(N491) );
  NOR2X1M U706 ( .A(n123), .B(n596), .Y(N490) );
  NOR2X1M U707 ( .A(n124), .B(n596), .Y(N489) );
  NOR2X1M U708 ( .A(n125), .B(n596), .Y(N488) );
  NOR2X1M U709 ( .A(n126), .B(n596), .Y(N487) );
  NOR2X1M U710 ( .A(n127), .B(n596), .Y(N486) );
  NOR2X1M U711 ( .A(n128), .B(n596), .Y(N485) );
  NOR2X1M U712 ( .A(n129), .B(n596), .Y(N484) );
  NOR2X1M U713 ( .A(n130), .B(n596), .Y(N483) );
  NOR2X1M U714 ( .A(n131), .B(n596), .Y(N482) );
  NOR2X1M U715 ( .A(n132), .B(n596), .Y(N481) );
  NOR2X1M U716 ( .A(n133), .B(n596), .Y(N480) );
  NOR2X1M U717 ( .A(n134), .B(n596), .Y(N479) );
  XNOR2X1M U718 ( .A(n597), .B(n598), .Y(N476) );
  NOR2X1M U719 ( .A(n599), .B(n600), .Y(n598) );
  XNOR2X1M U720 ( .A(N_bits[2]), .B(n599), .Y(N475) );
  NAND2BX1M U721 ( .AN(n601), .B(n548), .Y(n599) );
  XNOR2X1M U722 ( .A(n602), .B(n548), .Y(N473) );
  NOR2X1M U723 ( .A(n508), .B(n603), .Y(n548) );
  OAI22X1M U724 ( .A0(n604), .A1(n605), .B0(n135), .B1(n606), .Y(N402) );
  NOR2X1M U725 ( .A(n604), .B(n607), .Y(n606) );
  OAI22X1M U726 ( .A0(n608), .A1(n605), .B0(n136), .B1(n609), .Y(N401) );
  NOR2X1M U727 ( .A(n608), .B(n607), .Y(n609) );
  OAI22X1M U728 ( .A0(n605), .A1(n570), .B0(n137), .B1(n610), .Y(N400) );
  NOR2X1M U729 ( .A(n607), .B(n570), .Y(n610) );
  OAI22X1M U730 ( .A0(n601), .A1(n605), .B0(n138), .B1(n611), .Y(N399) );
  NOR2X1M U731 ( .A(n601), .B(n607), .Y(n611) );
  NAND3X1M U732 ( .A(n600), .B(n597), .C(n612), .Y(n607) );
  CLKNAND2X2M U733 ( .A(n613), .B(n600), .Y(n605) );
  CLKINVX1M U734 ( .A(N_bits[2]), .Y(n600) );
  OAI22X1M U735 ( .A0(n604), .A1(n614), .B0(n139), .B1(n615), .Y(N398) );
  NOR2X1M U736 ( .A(n604), .B(n616), .Y(n615) );
  OAI22X1M U737 ( .A0(n608), .A1(n614), .B0(n140), .B1(n617), .Y(N397) );
  NOR2X1M U738 ( .A(n608), .B(n616), .Y(n617) );
  CLKINVX1M U739 ( .A(n571), .Y(n608) );
  NOR2X1M U740 ( .A(n602), .B(N_bits[1]), .Y(n571) );
  OAI22X1M U741 ( .A0(n570), .A1(n614), .B0(n141), .B1(n618), .Y(N396) );
  NOR2X1M U742 ( .A(n570), .B(n616), .Y(n618) );
  CLKNAND2X2M U743 ( .A(N_bits[1]), .B(n602), .Y(n570) );
  CLKINVX1M U744 ( .A(N_bits[0]), .Y(n602) );
  OAI22X1M U745 ( .A0(n601), .A1(n614), .B0(n142), .B1(n619), .Y(N395) );
  NOR2X1M U746 ( .A(n601), .B(n616), .Y(n619) );
  NAND3X1M U747 ( .A(N_bits[2]), .B(n597), .C(n612), .Y(n616) );
  CLKINVX1M U748 ( .A(n620), .Y(n612) );
  CLKNAND2X2M U749 ( .A(n613), .B(N_bits[2]), .Y(n614) );
  NOR3X1M U750 ( .A(n508), .B(N_bits[3]), .C(n621), .Y(n613) );
  CLKNAND2X2M U751 ( .A(N_bits[0]), .B(N_bits[1]), .Y(n601) );
  OAI32X1M U752 ( .A0(n621), .A1(n508), .A2(n576), .B0(n646), .B1(n622), .Y(
        N394) );
  NOR2X1M U753 ( .A(n576), .B(n620), .Y(n622) );
  CLKNAND2X2M U754 ( .A(n623), .B(n596), .Y(n620) );
  CLKINVX1M U755 ( .A(n508), .Y(n596) );
  NAND4X1M U756 ( .A(n624), .B(n625), .C(n626), .D(n627), .Y(n508) );
  NOR4X1M U757 ( .A(n628), .B(n629), .C(n630), .D(n631), .Y(n627) );
  XNOR2X1M U758 ( .A(dvsr[2]), .B(n132), .Y(n631) );
  XNOR2X1M U759 ( .A(dvsr[1]), .B(n133), .Y(n630) );
  XNOR2X1M U760 ( .A(n118), .B(dvsr[15]), .Y(n629) );
  XNOR2X1M U761 ( .A(dvsr[0]), .B(n134), .Y(n628) );
  NOR4X1M U762 ( .A(n632), .B(n633), .C(n634), .D(n635), .Y(n626) );
  XNOR2X1M U763 ( .A(dvsr[6]), .B(n128), .Y(n635) );
  XNOR2X1M U764 ( .A(dvsr[5]), .B(n129), .Y(n634) );
  XNOR2X1M U765 ( .A(dvsr[4]), .B(n130), .Y(n633) );
  XNOR2X1M U766 ( .A(dvsr[3]), .B(n131), .Y(n632) );
  NOR4X1M U767 ( .A(n636), .B(n637), .C(n638), .D(n639), .Y(n625) );
  XNOR2X1M U768 ( .A(dvsr[9]), .B(n125), .Y(n639) );
  XNOR2X1M U769 ( .A(dvsr[8]), .B(n126), .Y(n638) );
  XNOR2X1M U770 ( .A(dvsr[7]), .B(n127), .Y(n637) );
  XNOR2X1M U771 ( .A(dvsr[10]), .B(n124), .Y(n636) );
  NOR4X1M U772 ( .A(n640), .B(n641), .C(n642), .D(n643), .Y(n624) );
  XNOR2X1M U773 ( .A(dvsr[14]), .B(n120), .Y(n643) );
  XNOR2X1M U774 ( .A(dvsr[13]), .B(n121), .Y(n642) );
  XNOR2X1M U775 ( .A(dvsr[12]), .B(n122), .Y(n641) );
  XNOR2X1M U776 ( .A(dvsr[11]), .B(n123), .Y(n640) );
  CLKNAND2X2M U777 ( .A(n644), .B(n623), .Y(n621) );
  AND2X1M U778 ( .A(n573), .B(n555), .Y(n623) );
  AOI21X1M U779 ( .A0(cmd[0]), .A1(cmd[1]), .B0(cmd[2]), .Y(n573) );
  CLKMX2X2M U780 ( .A(sda_output_m), .B(sda_input_s), .S0(n645), .Y(n644) );
  XNOR2X1M U781 ( .A(cmd[1]), .B(n576), .Y(n645) );
  CLKINVX1M U782 ( .A(n603), .Y(n576) );
  NOR3X1M U783 ( .A(n604), .B(N_bits[2]), .C(n597), .Y(n603) );
  CLKINVX1M U784 ( .A(N_bits[3]), .Y(n597) );
  OR2X1M U785 ( .A(N_bits[1]), .B(N_bits[0]), .Y(n604) );
  NOR2X1M U786 ( .A(n118), .B(n532), .Y(N182) );
  NOR2X1M U787 ( .A(n120), .B(n532), .Y(N181) );
  NOR2X1M U788 ( .A(n121), .B(n532), .Y(N180) );
  NOR2X1M U789 ( .A(n122), .B(n532), .Y(N179) );
  NOR2X1M U790 ( .A(n123), .B(n532), .Y(N178) );
  NOR2X1M U791 ( .A(n124), .B(n532), .Y(N177) );
  NOR2X1M U792 ( .A(n125), .B(n532), .Y(N176) );
  NOR2X1M U793 ( .A(n126), .B(n532), .Y(N175) );
  NOR2X1M U794 ( .A(n127), .B(n532), .Y(N174) );
  NOR2X1M U795 ( .A(n128), .B(n532), .Y(N173) );
  NOR2X1M U796 ( .A(n129), .B(n532), .Y(N172) );
  NOR2X1M U797 ( .A(n130), .B(n532), .Y(N171) );
  NOR2X1M U798 ( .A(n131), .B(n532), .Y(N170) );
  NOR2X1M U799 ( .A(n132), .B(n532), .Y(N169) );
  NOR2X1M U800 ( .A(n133), .B(n532), .Y(N168) );
  NOR2X1M U801 ( .A(n134), .B(n532), .Y(N167) );
  CLKNAND2X2M U802 ( .A(n557), .B(n558), .Y(n555) );
  CLKINVX1M U803 ( .A(cmd[1]), .Y(n558) );
  CLKINVX1M U804 ( .A(cmd[0]), .Y(n557) );
endmodule

