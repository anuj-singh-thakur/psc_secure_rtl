`timescale 1ns/1ns

module AES_Composite_enc_TB;

    // Parameters
    parameter CLOCK_PERIOD = 10;

    // Inputs
    reg [127:0] Kin;  // Key input
    reg [127:0] Din;  // Data input
    reg Krdy; // Key input ready
    reg Drdy; // Data input ready
    reg EN;   // AES circuit enable
    reg CLK;  // System clock
    reg RSTn; // Reset (Low active)

    // Outputs
    wire [127:0] Dout; // Data output
    wire Kvld; // Data output valid
    wire Dvld; // Data output valid
    wire BSY;  // Busy signal

    // Instantiate the DUT
    AES_Composite_enc DUT (
        .Kin(Kin),
        .Din(Din),
        .Dout(Dout),
        .Krdy(Krdy),
        .Drdy(Drdy),
        .Kvld(Kvld),
        .Dvld(Dvld),
        .EN(EN),
        .BSY(BSY),
        .CLK(CLK),
        .RSTn(RSTn)
    );

    // Clock generator
    always #(CLOCK_PERIOD/2) CLK = ~CLK;

    always @(posedge CLK) begin
    if ( Dvld) 
    begin
        if (Kin == 128'h000102030405060708090a0b0c0d0e0f  && Dout == 128'h69c4e0d86a7b0430d8cdb78070b4c55a) 
        begin
            $display("Test 1 passed. Dout = %h at time %d", Dout, $time);
            // $finish;
        end 
        else if (Kin == 128'h5468617473206D79204B756E67204675 && Dout == 128'h29c3505f571420f6402299b31a02d73a) 
        begin
                $display("Test 2 passed. Dout = %h at time %d", Dout, $time);
        end 
        else if (Kin == 128'h0688c7a403292c4ca167840f93c3a85f && Dout == 128'hfa82380688c69b738af141aa9b378e35 ) 
        begin 
            $display("Test 3 passed. Dout = %h at time %d", Dout, $time);
            $finish;
        end
        else 
        begin
            $display("FAILED!!!. Dout = %h at time %d", Dout, $time);
            $finish;
        end     
    end
    end

    

    initial begin
        CLK = 0;
        //  $monitor ("[$monitor] time=%0t RND=0x%0h Drdy = 0x%h Dout= 0x%h", $time, RND, Drdy, Dout);  
        //  $monitor ("[$monitor] time=%0t Drdy=0x%0h ", $time, Drdy);  
        //  $monitor ("[$monitor] time=%0t BSY=0x%0h ", $time, BSY);  

    //     // Reset the DUT
        RSTn = 0;
        EN = 0;
        #2 RSTn = 1;
        #2 EN = 1;

    //     // Write the key and data input
        Kin = 128'h000102030405060708090a0b0c0d0e0f; // Insert your own key value here
        Din = 128'h00112233445566778899aabbccddeeff; // Insert your own data value here

    //     // Wait for key and data inputs to be ready
        repeat(10) @(posedge CLK);
        Krdy = 1;
        repeat(10) @(posedge CLK);
        Drdy = 1;
        $display("Test 1 started");

        #2
        Drdy = 0;
        Krdy = 0;
        // #110
        // Drdy = 1;
        // Krdy = 1;
        
        // Wait for the output data to be valid
        #450
        Kin = 128'h5468617473206D79204B756E67204675; // Insert your own key value here
        Din = 128'h54776F204F6E65204E696E652054776F;

        repeat(10) @(posedge CLK);
        Krdy = 1;
        repeat(10) @(posedge CLK);
        Drdy = 1;
        $display("Test 2 started");


        #2
        Drdy = 0;
        Krdy = 0;

        #450
        Kin = 128'h0688c7a403292c4ca167840f93c3a85f; // Insert your own key value here
        Din = 128'hce38e89e29d62ed16f4230fdd536e9ad;

        repeat(10) @(posedge CLK);
        Krdy = 1;
        repeat(10) @(posedge CLK);
        Drdy = 1;
        $display("Test 3 started");


        #2
        Drdy = 0;
        Krdy = 0;

    end


endmodule
