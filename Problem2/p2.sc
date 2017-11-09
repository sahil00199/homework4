loadmatfile('p2data.mat') //load the values of all the arrays

f0=scf(0) //open a new window
nan_boxplot(meanErrors) //plot the graph
a = gca();
axes = get("current_axes")
//axes.data_bounds=[0,0;11, 0.6] //set the range of the y axis for uniformity across graphs
a.x_ticks = tlist(["ticks", "locations", "labels"], (0:5)', ["";"10"; "100"; "1000"; "10000"; "100000"]); //set the numbering for the x-axis
title("Errors in the MLE for mean", "fontsize", 4); //set the title of the graph
xlabel("Size of data", "fontsize", 2); //set the label of the x-axis
ylabel("Relative Errors in estimate") //set the label of the y-axis

f1=scf(0) //open a new window
nan_boxplot(covErrors) //plot the graph
a = gca();
axes = get("current_axes")
//axes.data_bounds=[0,0;11, 0.6] //set the range of the y axis for uniformity across graphs
a.x_ticks = tlist(["ticks", "locations", "labels"], (0:5)', ["";"10"; "100"; "1000"; "10000"; "100000"]); //set the numbering for the x-axis
title("Errors in the MLE for covariance matrix", "fontsize", 4); //set the title of the graph
xlabel("Size of data", "fontsize", 2); //set the label of the x-axis
ylabel("Relative Errors in estimate") //set the label of the y-axis
