sample_data = [... 
    2.5 47 1;
    2.1 36 1;
    2.9 52 0;
    3.1 57 0;
    2.2 51 1;
    2.8 55 0;
    1.9 36 1;
    2.5 43 1;
    2.2 49 0;
    3.1 51 1    ];
    
    figure (1);
    gscatter (sample_data(:,1), sample_data(:,2), sample_data(:,3), 'rb');
    hold on
    
    