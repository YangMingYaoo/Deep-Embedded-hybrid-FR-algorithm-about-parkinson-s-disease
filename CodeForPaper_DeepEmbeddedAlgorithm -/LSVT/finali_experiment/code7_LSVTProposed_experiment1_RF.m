function [ LSVTProposed_experiment1_RF ] =  LSVTProposed_experiment1_RF()
clc;clear ;warning('off');
% load('ttraintestdata.mat');%���ݼ���ȡ
load('PD_LSVTsample');%���ݼ���ȡ

ACC_w1_all=[];
tr2=[]
TPi = [];
FNi = [];
FPi = [];
TNi = [];
ACCi = [];
Prei = [];
Reci = [];
Spei = [];
G_meani = [];
F1_scorei = [];
Mean_scores = {};    
CMi = {}; 
svml3 = [];
scores = [];
ensemble = [];
LSVTProposed_experiment1_RF = [];


for i=1:1
    FinalAcc=[];
    ensemble=[];
    for s=1:3
%       load('traintestdata.mat');%���ݼ���ȡ ,����ΪʲôҪ�Ǽ����������ݼ���
        trainX1 = traindataX{1,s}(:,1:end-1);
        trainY1 = traindataX{1,s}(:,end);
        validX = valid_data(:,1:end-1);  
        validY = valid_data(:,end);
        testX = test_data(:,1:end-1);
        testY = test_data(:,end);
       %% ������׼������
       [trainX1, mu, sigma] = featureCentralize(trainX1);%%��������׼��������N(0,1)�ֲ���
       testX = bsxfun(@minus, testX, mu);
       testX = bsxfun(@rdivide, testX, sigma);
       validX = bsxfun(@minus, validX, mu);
       validX = bsxfun(@rdivide, validX, sigma);    
       a=[];
       m = 1;
       p=0;
       % l=1;
       tic
       iter= 6; % number of iterations
%        Models=cell(iter,1); % For saving the models from each iteration 
       Us=cell(iter,1); % For saving the Us from each iteration
%        Trainingdata=cell(iter,1); % For saving the training data from each iteration to calculate the corresponding Alpha
       % while (m>0.0001)
       for z = 1:iter
           % [fea,U,model,indx,misX,misY] = adbstLDPP(trainX,trainY,testX,testY,type_num);
            %������з�����õ�fea,������õ�model��������õ�U.��õ�U �϶���ά�ȱȽϵ͵�
           [fea,U,model,indx,misX,misY] = LSVTProposed_adbstLDPP_RF(trainX1,trainY1,validX,validY,type_num);
           Us{z}=U;
           feature{z,1}=fea; % Saving the features for each iteration
           Trainingdata{z,1} = [trainX1 trainY1]; % combining training data with its labels. Since in each iteration training data will be changed, we need to save corresponding labels
           Medels{z,1}=model;
           trainX1 = [misX;trainX1]; % combining the training data with miss classified samples
           trainY1 = [misY;trainY1];% combining the training lebels with miss classified labels
           for i=1:size (misY)
               b=corr(misX(:,i),misY); % Finding the error. however result id NaN because miss classified samples belong to single class.
               a=[a b];
           end
        % m1=(sum(a))/size (misY,1);
        % p=[p m1];
        % m =[m abs(p(1,z)-p(1,z+1))];
        % a=[];
        % l=l+1;
        falgA = double(isempty(misX));
        if  falgA 
            break
        end
       end

       % Finding Alpha
       alpha=FInd_Alpha(Trainingdata); % finding the alpha for training data of each iteration
       % alpha(1)=0.5;
       % Test process
       svml8 = [];
       svm_prede=[]
       %���Լ��Ͻ��в���ģ��,�ó�Ԥ��Ľ��
      
       
       for i=1:size(Trainingdata)
           test1=testX*(Us{i}); % Coressponding U
           mod1=Medels{i}% Corresponding model
           fea=feature{i};% Coressponding Feature
           test1=test1(:,fea);
%            svm_pred1 = svmpredict(testY,test1,mod1);
           [svm_pred1,votes] = classRF_predict(test1,mod1)
           [ind]=find(svm_pred1==2); % Because Sgn function works with labels -1 and 1 so here I changed all my labels from 2 to -1 to make it possible(1,-1) before saving
           svm_pred1(ind,1)=-1;
           svm_pred1=svm_pred1*alpha(i); % Multiplication of alpha with corresponding prediction
           svm_prede=[svm_prede svm_pred1];
       end

  
      %% Prediction  Ԥ�⾫�ȼ���
       [ind] = find(testY==2); % Changing labels having value 2 to -1 for calculation of accuracy
       testY(ind,1) = -1;      %��testY��Ϊ-2�ĸ�Ϊ-1.
       Final_predict=sum(svm_prede,2);
       Result=sign(Final_predict);
       Final_Accuracy_with_Adaboost = mean(Result == testY) * 100; % Final accuracy
       ensemble=[ensemble Result];
       FinalAcc=[FinalAcc Final_Accuracy_with_Adaboost];
       
       %% ÿһ���ӿռ������ָ��
       Y_unique = unique(testY);
       %��ÿһ���ӿռ�Ļ������󶼱�������
       CMi{s} = zeros(size(Y_unique,1),size(Y_unique,1));
       for n = 1:2
           in = find(testY == Y_unique(n,1)); %�ҳ�ʵ�ʱ�ǩΪĳһ���ǩ��λ�á�
           Y_pred = Result(in,1);
           CMi{s}(n,1) = size(find(Y_pred == Y_unique(1,1)),1)%�ҵ�Ԥ���ǩ����ʵ��ǩ��ȵ�����
           CMi{s}(n,2) = size(find(Y_pred == Y_unique(2,1)),1)%�ҵ�Ԥ���ǩ����ʵ��ǩ����ȵ�����
       end
       % ��ÿһ���ӿռ�Ļ����������ֵ��¼����
       TPi(s,:) = CMi{s}(1,1);
       FNi(s,:) = CMi{s}(1,2);
       FPi(s,:) = CMi{s}(2,1);
       TNi(s,:) = CMi{s}(2,2);
       %��ÿһ���ӿռ������ָ��ֵ��¼����
       ACCi(s,:) = (TPi(s,:) + TNi(s,:)) / (TPi(s,:) + TNi(s,:) + FPi(s,:) + FNi(s,:));
       Prei(s,:) = TPi(s,:) / (TPi(s,:) + FPi(s,:));
       Reci(s,:) = TPi(s,:) / (TPi(s,:) + FNi(s,:));
       Spei(s,:) = TNi(s,:) / (FPi(s,:) + TNi(s,:)); %����
       
       G_meani(s,:) = sqrt(Reci(s,:) * Spei(s,:));
       F1_scorei(s,:) = (2 * Prei(s,:) * Reci(s,:)) / (Prei(s,:) + Reci(s,:))
       
       
       clear Trainingdata
    end
    
   load 'weight'%��������������Ȩ�� 
   m_w = size(weight,1);     %��������������Ѱ���Ȩ��
   for i = 1:m_w
       w1 = weight(i,:);
       P = sign(ensemble(:,1) * w1(1,1)+ ensemble(:,2) * w1(1,2) + ensemble(:,3) * w1(1,3));
       Final_Accuracy_with_ensebleL = mean(P == testY) * 100; % Final accuracy
       ACC_w1_all = [ACC_w1_all; Final_Accuracy_with_ensebleL];
   end
   %% ����ָ����ش���
   ACC_svml_tt = max(ACC_w1_all);
   [indx] = find(ACC_w1_all== max(max(ACC_w1_all)));
   best_weight = weight(indx,:);
   %best_P����õ�Ԥ��ɣ�����Ԥ������������
   best_Pred = sign(ensemble(:,1) * best_weight(1,1) + ensemble(:,2) * best_weight(1,2) + ensemble(:,3) * best_weight(1,3));
   % ������һ��ͨ�õĽ�����������Ĵ���,�����㼸������ָ��Ĵ���
   % best_Pred ��Ԥ���ǩ��testY����ʵ��ǩ��������һ��֮��Ԥ���ǩ����ʵ��ǩ��Ϊ1��-1��ԭ����2��תΪ-1�ˡ�
   Y_unique = unique(testY);
   CM = zeros(size(Y_unique,1),size(Y_unique,1));
   for i = 1:2
           in = find(testY == Y_unique(i,1)); %�ҳ�ʵ�ʱ�ǩΪĳһ���ǩ��λ�á�
           Y_pred =  best_Pred(in,1);
           CM(i,1) = size(find(Y_pred == Y_unique(1,1)),1);%�ҵ�Ԥ���ǩ����ʵ��ǩ��ȵ�����
           CM(i,2) = size(find(Y_pred == Y_unique(2,1)),1);%�ҵ�Ԥ���ǩ����ʵ��ǩ����ȵ�����
   end
   %�������Ϊ�Ǳ���ģ�ֻ���ڲ�����ԭʼ�����������ʽʱ��ʹ�á�
 
   TP = CM(1,1);
   FN = CM(1,2);
   FP = CM(2,1);
   TN = CM(2,2);
   %����д����ָ��
   ACC = (TP+TN) / (TP + TN + FP + FN);
   Pre = TP / (TP + FP);
   Rec = TP / (TP + FN);
   Spe = TN / (FP+ TN); %����
   
   G_mean = sqrt(Rec * Spe);
    F1_score_Final = (2 * Pre * Rec) / (Pre + Rec);
   %%
   fprintf('\nproposed with binary+svml Accuracy(train&test): %f\n', ACC_svml_tt);
   tr2=[tr2;ACC_svml_tt];   
   LSVTProposed_experiment1_RF.ACC = ACC;   
   LSVTProposed_experiment1_RF.ACCi = ACCi; 
   LSVTProposed_experiment1_RF.Pre = Pre;
   LSVTProposed_experiment1_RF.Prei = Prei; 
   LSVTProposed_experiment1_RF.Rec = Rec; 
   LSVTProposed_experiment1_RF.Reci = Reci; 
   LSVTProposed_experiment1_RF.Spe = Spe; 
   LSVTProposed_experiment1_RF.Spei = Spei;
   LSVTProposed_experiment1_RF.G_mean = G_mean; 
   LSVTProposed_experiment1_RF.G_meani = G_meani; 
      LSVTProposed_experiment1_RF.F1_score_Final = F1_score_Final; 
   LSVTProposed_experiment1_RF.F1_scorei = F1_scorei; 
 
end
toc
end
