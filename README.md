# Alteramon
A Pokemon-style RPG base built for the Altera FPGA constructed over 4-weeks with partner Yi-Rui for UIUC's ECE 385, [Digital Systems Laboratory](https://ece.illinois.edu/academics/courses/profile/ECE385).  Tested on the [Altera DE-2 115 Devlopment Board](https://www.altera.com/solutions/partners/partner-profile/terasic-inc-/board/altera-de2-115-development-and-education-board.html).

## Features
+ Responsive WASD Keyboard Control over the EZ-OTG USB Controller
+ Capability to run VGA output at full 640x480 resolution at 30Hz, with 16 bit Color
+ Uses sophisticated graphics routines to quickly load graphics data and construct graphics buffers
+ Features over 300 different tiles (16*20=320) tiles, along with player sprites
+ Easily supports the addition of 256-Color tilesets and new map constructions

### Relevant Design Choices

Because of the scale of the project and the limited time available for the project, we had to make several design decisions that let us emulate as many features of the game while keeping in mind technical and implementation difficulties

#### Graphics Compression and Drawing

##### Choosing the appropriate memory
There are four different types of memory on the FPGA: SRAM, SDRAM, Flash, and OCM (on-chip memory).  The various tradeoffs are listed below:
+ **SRAM:** 2MB, low latency, R/W
+ **SDRAM:** 128MB, medium/variable latency, R/W
+ **Flash:** 8MB, medium high latency, effectively R-only
+ **OCM:** ~.1MB, lowest latency, R/W, simplest interface 

To implement the core graphics of the game, we needed two different significant memory chunks: the graphics buffer and the sprite assets.  Because of the high 640x480 resolution at 30hz signal that is demanded by the VGA, and keeping in mind that we may have graphics routines that may want to update the buffer frequently, we saw that that the OCM was a natural choice because of its quick access times.  

However, we for the large number sprites and graphics assets that we would eventually add into the game, and keeping in mind that we may want extra space in the future to expand the graphics available to us, we needed a large memory to store much of the art assets that would be drawn to the buffer.  The SRAM, while not as large as some of the other memory providide on the DE-2, has low enough latency so that a read request sent to the SRAM is available in 2-clock cycles.  Additionally, we were able to use an SRAM controller provided online by Shawn Gerber.  

##### Simplifying the data

To keep read times as low as possible, we used a palette to store the color data both for the SRAM assets and the frame buffer.  Because the SRAM reads packets of 8 bytes, instead of storing RGB as 3 eight-bit values, which would match the 24-bit color operation of the VGA, we instead use each of the 256 values and map them to a specific color used in the art assets.  This provides memory savings of 66%, and increases the speed of the draw routines by about 33%.  

##### Using tilesets

In the game, there are several maps or zones, that the player can travel to.  To generate the data for each map, rather than store a whole 640x480 image of the map in the memory for each zone (640 columns x 480 rows x 1 byte per pixel = ~0.3MB), we used tilemapping to provide us with easily editable, extremely efficient yet dynamic maps for each zone.  

![Tilesheet Example](https://raw.githubusercontent.com/Tarokan/ECE-385-Final-Project/master/sprite_assets/tilemap12.9b.png)

Each tile provides the zone for small 16x16 block of the screen.  16 comfortably divides into 640 and 480, 40 and 30 times respectably, which means each zone has a large area to draw 1200 tiles.  Using the tilesheet (which is later converted into byte data and loaded into the SRAM), we can custom make tilesheets using indices, which refer to a specific tile, counting left to right, top to bottom, starting at 1.  The byte code of these indices for each map can be found in the `maps/` folder. 

There are about 300 tiles, so each tile could be represented with 12 bits (while 2^12 >> 300, this also allows for later expansion).  This means each map takes 40 colunms x 30rows x 1.5 bytes = ~.015MB per map, which is more than 20 times smaller than before. 

README is WIP!  Please check back later for more details. 
