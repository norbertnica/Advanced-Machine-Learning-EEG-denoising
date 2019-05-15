function [normalData, abnormalData] = pickDataSet(pn)
% pickDataSet
%   This function returns fragments of normal and abnormal data.
%
% INPUT
%   pn : Patient number n
%
% OUTPUT
%   normalData   : cell containing the data indentified as normal
%   abnormalData : cell containing the data indentified as abnormal

% Load the data here
tmp = num2str(pn)+".edf";
[hdr, record] = edfread(tmp);

% Manage the data
data = record(1:end-1,:);
fs = hdr.frequency(1); %Nb of data points per second

if pn==1
    normalData = cell(1,4);
    normalData{1} = data(:, 2*fs*114:2*fs*168);
    normalData{2} = data(:, 2*fs*265:2*fs*303);
    normalData{3} = data(:, 2*fs*325:2*fs*355);
    normalData{4} = data(:, 2*fs*358:2*fs*392);
    
    abnormalData = cell(1,6);
    abnormalData{1} = data(:, 1:2*fs*14);
    abnormalData{2} = data(:, 2*fs*26:2*fs*42);
    abnormalData{3} = data(:, 2*fs*391:2*fs*410);
    abnormalData{4} = data(:, 2*fs*464:2*fs*524);
    abnormalData{5} = data(:, 2*fs*546:2*fs*557);
    abnormalData{6} = data(:, 2*fs*641:2*fs*699);
    
elseif pn==2
    normalData = cell(1,3);
    normalData{1} = data(:,2*fs*1420:2*fs*1450);  % 60
    normalData{2} = data(:,2*fs*1500:2*fs*1520); % 40
    normalData{3} = data(:,2*fs*100:2*fs*200); % 200
    
    abnormalData = cell(1,6);
    abnormalData{1} = data(:,2*fs*778:2*fs*780); % 4
    abnormalData{2} = data(:,2*fs*940:2*fs*942); %
    abnormalData{3} = data(:,2*fs*1796:2*fs*1801);
    abnormalData{4} = data(:,2*fs*7:2*fs*24);
    abnormalData{5} = data(:,2*fs*1449:2*fs*1451);
    abnormalData{6} = data(:,2*fs*1581:2*fs*1585);
    
    
elseif pn==3
    normalData = cell(1,8);
    normalData{1} = data(:,2*fs*349:2*fs*357);
    normalData{2} = data(:,2*fs*946:2*fs*955);
    normalData{3} = data(:,2*fs*981:2*fs*1004);
    normalData{4} = data(:,2*fs*1096:2*fs*1108);
    normalData{5} = data(:,2*fs*1126:2*fs*1139);
    normalData{6} = data(:,2*fs*1178:2*fs*1187);
    normalData{7} = data(:,2*fs*1243:2*fs*1281);
    normalData{8} = data(:,2*fs*1471:2*fs*1529);
    
    abnormalData = cell(1,9);
    abnormalData{1} = data(:,2*fs*319:2*fs*343);
    abnormalData{2} = data(:,2*fs*362:2*fs*370);
    abnormalData{3} = data(:,2*fs*377:2*fs*414);
    abnormalData{4} = data(:,2*fs*498:2*fs*526);
    abnormalData{5} = data(:,2*fs*535:2*fs*546);
    abnormalData{6} = data(:,2*fs*611:2*fs*627);
    abnormalData{7} = data(:,2*fs*699:2*fs*704);
    abnormalData{8} = data(:,2*fs*707:2*fs*733);
    abnormalData{9} = data(:,2*fs*745:2*fs*765);
    
elseif pn==4
    normalData = cell(1,4);
    normalData{1} = data(:, 2*fs*42:2*fs*86);
    normalData{2} = data(:, 2*fs*265:2*fs*303);
    normalData{3} = data(:, 2*fs*325:2*fs*355);
    normalData{4} = data(:, 2*fs*358:2*fs*392);
    
    abnormalData = cell(1,21);
    abnormalData{1} = data(:, 1:2*fs*10);
    abnormalData{2} = data(:, 2*fs*25:2*fs*37);
    abnormalData{3} = data(:, 2*fs*105:2*fs*116);
    abnormalData{4} = data(:, 2*fs*186:2*fs*191);
    abnormalData{5} = data(:, 2*fs*303:2*fs*306);
    abnormalData{6} = data(:, 2*fs*367:2*fs*371);
    abnormalData{7} = data(:, 2*fs*385:2*fs*393);
    abnormalData{8} = data(:, 2*fs*397:2*fs*403);
    abnormalData{9} = data(:, 2*fs*493:2*fs*514);
    abnormalData{10} = data(:, 2*fs*521:2*fs*524);
    abnormalData{11} = data(:, 2*fs*532:2*fs*534);
    abnormalData{12} = data(:, 2*fs*577:2*fs*587);
    abnormalData{13} = data(:, 2*fs*607:2*fs*617);
    abnormalData{14} = data(:, 2*fs*749:2*fs*757);
    abnormalData{15} = data(:, 2*fs*818:2*fs*820);
    abnormalData{16} = data(:, 2*fs*836:2*fs*841);
    abnormalData{17} = data(:, 2*fs*860:2*fs*872);
    abnormalData{18} = data(:, 2*fs*1046:2*fs*1052);
    abnormalData{19} = data(:, 2*fs*1057:2*fs*1071);
    abnormalData{20} = data(:, 2*fs*1166:2*fs*1169);
    abnormalData{21} = data(:, 2*fs*1227:2*fs*1231);
    
elseif pn==5
    normalData = cell(1,5);
    normalData{1} = data(:,2*fs*90:2*fs*120);
    normalData{2} = data(:,2*fs*430:2*fs*440);
    normalData{3} = data(:,2*fs*510:2*fs*564);
    normalData{2} = data(:,2*fs*630:2*fs*683);
    normalData{3} = data(:,2*fs*750:2*fs*783);
    
    abnormalData = cell(1,6);
    abnormalData{1} = data(:,1:2*fs*30);
    abnormalData{2} = data(:,2*fs*255:2*fs*260);
    abnormalData{3} = data(:,2*fs*440:2*fs*450);
    abnormalData{4} = data(:,2*fs*460:2*fs*485);
    abnormalData{5} = data(:,2*fs*274:2*fs*360);
    abnormalData{6} = data(:,2*fs*605:2*fs*620);
    
    %Suspected Epilepsy
    %580 -585
    %1480 - 1550
    
elseif pn==6
    normalData = cell(1,2);
    normalData{1} = data(:, 2*fs*26:2*fs*140);
    normalData{2} = data(:, 2*fs*157:2*fs*208);
    
    abnormalData = cell(1,21);    
    abnormalData{1} = data(:, 2*fs*12:2*fs*25);
    abnormalData{2} = data(:, 2*fs*260:2*fs*276);
    abnormalData{3} = data(:, 2*fs*382:2*fs*392);
    abnormalData{4} = data(:, 2*fs*475:2*fs*480);
    abnormalData{5} = data(:, 2*fs*529:2*fs*535);
    abnormalData{6} = data(:, 2*fs*574:2*fs*581);
    abnormalData{7} = data(:, 2*fs*587:2*fs*595);
    abnormalData{8} = data(:, 2*fs*704:2*fs*713);
    abnormalData{9} = data(:, 2*fs*719:2*fs*730);
    abnormalData{10} = data(:, 2*fs*822:2*fs*824);
    abnormalData{11} = data(:, 2*fs*834:2*fs*839);
    abnormalData{12} = data(:, 2*fs*890:2*fs*908);
    abnormalData{13} = data(:, 2*fs*1008:2*fs*1023);
    abnormalData{14} = data(:, 2*fs*1319:2*fs*1326);
    abnormalData{15} = data(:, 2*fs*1442:2*fs*1450);
    abnormalData{16} = data(:, 2*fs*1522:2*fs*1527);
    abnormalData{17} = data(:, 2*fs*1554:2*fs*1558);
    abnormalData{18} = data(:, 2*fs*1586:2*fs*1587);
    abnormalData{19} = data(:, 2*fs*1595:2*fs*1598);
    abnormalData{20} = data(:, 2*fs*1633:2*fs*1636);
    abnormalData{21} = data(:, 2*fs*1640:2*fs*1645);
    
elseif pn==7
    normalData = cell(1,3);
    normalData{1} = data(:, 2*fs*28:2*fs*35);
    normalData{2} = data(:, 2*fs*239:2*fs*298);
    normalData{3} = data(:, 2*fs*1706:2*fs*1800);
    
    abnormalData = cell(1,16);
    abnormalData{1} = data(:, 2*fs*17:2*fs*28);
    abnormalData{2} = data(:, 2*fs*54:2*fs*57);
    abnormalData{3} = data(:, 2*fs*92:2*fs*93);
    abnormalData{4} = data(:, 2*fs*102:2*fs*125);
    abnormalData{5} = data(:, 2*fs*130:2*fs*137);
    abnormalData{6} = data(:, 2*fs*155:2*fs*165);
    abnormalData{7} = data(:, 2*fs*178:2*fs*181);
    abnormalData{8} = data(:, 2*fs*184:2*fs*190);
    abnormalData{9} = data(:, 2*fs*202:2*fs*212);
    abnormalData{10} = data(:, 2*fs*299:2*fs*303);
    abnormalData{11} = data(:, 2*fs*466:2*fs*493);
    abnormalData{12} = data(:, 2*fs*520:2*fs*525);
    abnormalData{13} = data(:, 2*fs*571:2*fs*585);
    abnormalData{14} = data(:, 2*fs*741:2*fs*753);
    abnormalData{15} = data(:, 2*fs*900:2*fs*903);
    abnormalData{16} = data(:, 2*fs*1664:2*fs*1676);
    
elseif pn==8
    normalData = cell(1,2);
    normalData{1} = data(:, 2*fs*236:2*fs*346);
    normalData{2} = data(:, 2*fs*400:2*fs*465);
    
    abnormalData = cell(1,5);
    abnormalData{1} = data(:, 2*fs*1:2*fs*29);
    abnormalData{2} = data(:, 2*fs*179:2*fs*220);
    abnormalData{6} = data(:, 2*fs*778:2*fs*855);
    abnormalData{7} = data(:, 2*fs*967:2*fs*987);
    
elseif pn==9
    disp('This data set is not working')
    return;
elseif pn==10
    normalData{1} = data(:, 2*fs*16:2*fs*24);
    normalData{2} = data(:, 2*fs*26:2*fs*43);
    normalData{3} = data(:, 2*fs*51:2*fs*64);
    normalData{4} = data(:, 2*fs*117:2*fs*246);
    
    abnormalData{1} = data(:, 2*fs*5:2*fs*16);
    abnormalData{2} = data(:, 2*fs*24:2*fs*26);
    abnormalData{3} = data(:, 2*fs*43:2*fs*45);
    abnormalData{4} = data(:, 2*fs*70:2*fs*77);
    abnormalData{5} = data(:, 2*fs*94:2*fs*117);
    abnormalData{6} = data(:, 2*fs*254:2*fs*275);
    abnormalData{7} = data(:, 2*fs*279:2*fs*288);
    abnormalData{8} = data(:, 2*fs*426:2*fs*440);
    abnormalData{9} = data(:, 2*fs*450:2*fs*486);
    abnormalData{10} = data(:, 2*fs*497:2*fs*501);
    abnormalData{11} = data(:, 2*fs*512:2*fs*536);
    
end

