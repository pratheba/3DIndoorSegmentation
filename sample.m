function [] = sample()
vertices = [0 0 0; 0 1 0; 1 1 0; 1 0 0; 2 1 0; 2 0 0; 1 2 0; 0 2 0; 0 3 0; 1 3 0; 2 3 0; 2 2 0; 0 0 1; 0 1 1; 0 2 1; 0 3 1; 2 3 1; 2 2 1; 1 2 1; 1 1 1; 2 1 1; 2 0 1; 1 3 1; 1 0 1; 0 0 -2; 0 4 -2; 0 4 3; 0 0 3];
faces = [1 2 3; 1 3 4; 4 3 5; 4 5 6; 2 7 3; 2 8 7; 8 9 10; 8 10 7; 7 10 11; 7 11 12; 15 16 9; 15 9 8; 14 15 8; 14 8 2; 13 14 2; 13 2 1; 12 11 17; 12 17 18; 6 5 21; 6 21 22; 3 7 19; 3 19 20; 18 17 23; 18 23 19; 19 23 16; 19 16 15; 20 19 15; 20 15 14; 22 21 20; 22 20 24; 24 20 14; 24 14 13; 10 9 16; 10 16 23; 11 10 23; 11 23 17; 1 4 13; 13 4 24; 4 6 24; 24 6 22; 7 12 19; 19 12 18; 3 20 5; 5 20 21; 25 26 27; 25 27 28];

startProcess(vertices, faces);

end