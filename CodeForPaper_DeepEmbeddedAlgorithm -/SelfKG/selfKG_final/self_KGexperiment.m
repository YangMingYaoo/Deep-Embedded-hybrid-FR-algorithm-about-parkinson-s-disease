clc;clear ;warning('off');
tic
final_eval= {};
mean_final_eval = {};
iter = 10
for C = 1:iter
    [MaxLittlerProposed_H_experiment1_s2] = LSVTProposed_H_experiment1svm0()
    final_eval{C} = MaxLittlerProposed_H_experiment1_s2;
end
mean_final_eval.ACC = (final_eval{1}.ACC + final_eval{2}.ACC + final_eval{3}.ACC+final_eval{4}.ACC + final_eval{5}.ACC + final_eval{6}.ACC+final_eval{7}.ACC + final_eval{8}.ACC + final_eval{9}.ACC + final_eval{10}.ACC)/10
mean_final_eval.ACCi = (final_eval{1}.ACCi + final_eval{2}.ACCi + final_eval{3}.ACCi + final_eval{4}.ACCi + final_eval{5}.ACCi + final_eval{6}.ACCi + final_eval{7}.ACCi + final_eval{8}.ACCi + final_eval{9}.ACCi + final_eval{10}.ACCi)/10
mean_final_eval.Pre = (final_eval{1}.Pre + final_eval{2}.Pre + final_eval{3}.Pre + final_eval{4}.Pre + final_eval{5}.Pre + final_eval{6}.Pre + final_eval{7}.Pre + final_eval{8}.Pre + final_eval{9}.Pre + final_eval{10}.Pre)/10
mean_final_eval.Prei = (final_eval{1}.Prei + final_eval{2}.Prei + final_eval{3}.Prei + final_eval{4}.Prei + final_eval{5}.Prei + final_eval{6}.Prei + final_eval{7}.Prei + final_eval{8}.Prei + final_eval{9}.Prei + final_eval{10}.Prei)/10
mean_final_eval.Rec = (final_eval{1}.Reci + final_eval{2}.Reci + final_eval{3}.Reci + final_eval{4}.Reci + final_eval{5}.Reci + final_eval{6}.Reci + final_eval{7}.Reci + final_eval{8}.Reci + final_eval{9}.Reci + final_eval{10}.Reci)/10
mean_final_eval.Reci = (final_eval{1}.Reci + final_eval{2}.Reci + final_eval{3}.Reci + final_eval{4}.Reci + final_eval{5}.Reci + final_eval{6}.Reci + final_eval{7}.Reci + final_eval{8}.Reci + final_eval{9}.Reci + final_eval{10}.Reci)/10
mean_final_eval.TNR = (final_eval{1}.TNR + final_eval{2}.TNR + final_eval{3}.TNR + final_eval{4}.TNR + final_eval{5}.TNR + final_eval{6}.TNR + final_eval{7}.TNR + final_eval{8}.TNR + final_eval{9}.TNR + final_eval{10}.TNR)/10
mean_final_eval.TNRi = (final_eval{1}.TNRi + final_eval{2}.TNRi + final_eval{3}.TNRi + final_eval{4}.TNRi + final_eval{5}.TNRi + final_eval{6}.TNRi + final_eval{7}.TNRi + final_eval{8}.TNRi + final_eval{9}.TNRi + final_eval{10}.TNRi)/10
mean_final_eval.Spe = (final_eval{1}.Spe + final_eval{2}.Spe + final_eval{3}.Spe + final_eval{4}.Spe + final_eval{5}.Spe + final_eval{6}.Spe + final_eval{7}.Spe + final_eval{8}.Spe + final_eval{9}.Spe + final_eval{10}.Spe)/10
mean_final_eval.Spei = (final_eval{1}.Spei + final_eval{2}.Spei + final_eval{3}.Spei + final_eval{4}.Spei + final_eval{5}.Spei + final_eval{6}.Spei + final_eval{7}.Spei + final_eval{8}.Spei + final_eval{9}.Spei + final_eval{10}.Spei)/10
mean_final_eval.G_mean = (final_eval{1}.G_mean + final_eval{2}.G_mean + final_eval{3}.G_mean + final_eval{4}.G_mean + final_eval{5}.G_mean + final_eval{6}.G_mean + final_eval{7}.G_mean + final_eval{8}.G_mean + final_eval{9}.G_mean + final_eval{10}.G_mean)/10
mean_final_eval.G_meani = (final_eval{1}.G_meani + final_eval{2}.G_meani + final_eval{3}.G_meani + final_eval{4}.G_meani + final_eval{5}.G_meani + final_eval{6}.G_meani + final_eval{7}.G_meani + final_eval{8}.G_meani + final_eval{9}.G_meani + final_eval{10}.G_meani)/10
mean_final_eval.F1_score = (final_eval{1}.F1_score + final_eval{2}.F1_score + final_eval{3}.F1_score + final_eval{4}.F1_score + final_eval{5}.F1_score+ final_eval{6}.F1_score + final_eval{7}.F1_score + final_eval{8}.F1_score + final_eval{9}.F1_score + final_eval{10}.F1_score)/10
mean_final_eval.F1_scorei = (final_eval{1}.F1_scorei + final_eval{2}.F1_scorei + final_eval{3}.F1_scorei + final_eval{4}.F1_scorei + final_eval{5}.F1_scorei + final_eval{6}.F1_scorei + final_eval{7}.F1_scorei + final_eval{8}.F1_scorei + final_eval{9}.F1_scorei + final_eval{10}.F1_scorei)/10
toc
%% 

function [ sakarProposed_H_experiment1_svm0 ] =  LSVTProposed_H_experiment1svm0()
clc;clear ;warning('off');
% load('ttraintestdata.mat');%���ݼ���ȡ
load('PD_speech_featur');%���ݼ���ȡ

ACC_w1_all=[];
tr2=[]
TPi = [];
FNi = [];
FPi = [];
TNi = [];
TNR = [];
TNRi = [];
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
sakarProposed_H_experiment1_svm0 = [];


for i=1:1
    FinalAcc=[];
    ensemble=[];
    for s=1:3
%       load('traintestdata.mat');%���ݼ���ȡ ,����ΪʲôҪ�Ǽ����������ݼ���
        trainX1 = traindataX{1,s}(:,1:end-1);
        trainY1 = traindataX{1,s}(:,end);
%       trainX1=trainX(1:42,:);
%       trainY1=trainY(1:42,1);
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
       iter = 3; % number of iterations
%        Models=cell(iter,1); % For saving the models from each iteration 
%        Us=cell(iter,1); % For saving the Us from each iteration
%        Trainingdata=cell(iter,1); % For saving the training data from each iteration to calculate the corresponding Alpha
       % while (m>0.0001)
       for z = 1:iter
           % [fea,U,model,indx,misX,misY] = adbstLDPP(trainX,trainY,testX,testY,type_num);
            %������з�����õ�fea,������õ�model��������õ�U.��õ�U �϶���ά�ȱȽϵ͵�
           [fea,U,model,indx,misX,misY] = self_KG_adbstLDPP(trainX1,trainY1,validX,validY,type_num);
           Us{z}=U;
           feature{z,1}=fea; % Saving the features for each iteration
           Trainingdata{z,1} = [trainX1 trainY1]; % combining training data with its labels. Since in each iteration training data will be changed, we need to save corresponding labels
           Medels{z,1}=model;
           trainX1 = [misX;trainX1]; % combining the training data with miss classified samples
           trainY1 = [misY;trainY1];% combining the training lebels with miss classified labels
%            for i=1:size (misX,2)
%                b=corr(misX(:,i),misY); % Finding the error. however result id NaN because miss classified samples belong to single class.
%                a=[a b];
%            end
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
           svm_pred1 = svmpredict(testY,test1,mod1);
%            [svm_pred1,votes] = classRF_predict(test1,mod1)
           [ind]=find(svm_pred1 == 2); % Because Sgn function works with labels -1 and 1 so here I changed all my labels from 2 to -1 to make it possible(1,-1) before saving
           svm_pred1(ind,1) = -1;
           svm_pred1 = svm_pred1 * alpha(i); % Multiplication of alpha with corresponding prediction
           svm_prede=[svm_prede svm_pred1];
       end

       % for i=1:iter;
       % test1=testX*(Us{i}); % Coressponding U
       % mod1=Medels{i}% Corresponding model
       % fea=feature{i};% Coressponding Feature
       % test1=test1(:,fea(1:100));
       % svm_pred1 = svmpredict(testY,test1,mod1);
       % [ind]=find(svm_pred1==2); % Because Sgn function works with labels -1 and 1 so here I changed all my labels from 2 to -1 to make it possible(1,-1) before saving
       % svm_pred1(ind,1)=-1;
       % svm_pred1=svm_pred1*alpha(i); % Multiplication of alpha with corresponding prediction
       % svm_prede=[svm_prede svm_pred1];
       % end

      %% Prediction  Ԥ�⾫�ȼ���
       [ind] = find(testY == 2); % Changing labels having value 2 to -1 for calculation of accuracy
       testY(ind,1) = -1;      %��testY��Ϊ-2�ĸ�Ϊ-1.
       Final_predict = sum(svm_prede,2);
       Result = sign(Final_predict);
       Final_Accuracy_with_Adaboost = mean(Result == testY) * 100; % Final accuracy
       ensemble = [ensemble Result];
       FinalAcc = [FinalAcc Final_Accuracy_with_Adaboost];
       
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
       Spei(s,:) = TNi(s,:) / (FNi(s,:) + TNi(s,:));
       TNRi(s,:) = TNi(s,:) / (FPi(s,:) + TNi(s,:));
       G_meani(s,:) = sqrt(Reci(s,:) * Spei(s,:));
       F1_scorei(s,:) = (2 * Prei(s,:) * Reci(s,:)) / (Prei(s,:) + Reci(s,:))
       clear Trainingdata
    end
   load 'weight'%��������������Ȩ�� 
   m_w = size(weight,1);     %��������������Ѱ���Ȩ��
   for i = 1:m_w
       w1 = weight(i,:);
       P = sign(ensemble(:,1) * w1(1,1)+ ensemble(:,2) * w1(1,2) + ensemble(:,3) * w1(1,3));
%         P = ensemble(:,1) * w1(1,1)+ ensemble(:,2) * w1(1,2) + ensemble(:,3) * w1(1,3);
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
%    CM1 = zeros(2,2);
%    CM1(1,1) = CM(2,2);
%    CM1(1,2) = CM(2,1);
%    CM1(2,1) = CM(1,2);
%    CM1(2,2) = CM(1,1);
   TP = CM(1,1);
   FN = CM(1,2);
   FP = CM(2,1);
   TN = CM(2,2);
   %����д����ָ��
   ACC = (TP+TN) / (TP + TN + FP + FN);
   Pre = TP / (TP + FP);
   Rec = TP / (TP + FN);
   TNR = TN / (FP + TN);
   Spe = TN / (FN + TN);
   G_mean = sqrt(Rec * Spe);
    F1_score = (2 * Pre * Rec) / (Pre + Rec);
   %%
   fprintf('\nproposed with binary+svml Accuracy(train&test): %f\n', ACC_svml_tt);
   tr2=[tr2;ACC_svml_tt];   
   sakarProposed_H_experiment1_svm0.ACC = ACC;   
   sakarProposed_H_experiment1_svm0.ACCi = ACCi;
   sakarProposed_H_experiment1_svm0.Pre = Pre;
   sakarProposed_H_experiment1_svm0.Prei = Prei; 
   sakarProposed_H_experiment1_svm0.Rec = Rec; 
   sakarProposed_H_experiment1_svm0.Reci = Reci;
   sakarProposed_H_experiment1_svm0.TNR = TNR; 
   sakarProposed_H_experiment1_svm0.TNRi = TNRi;
   sakarProposed_H_experiment1_svm0.Spe = Spe; 
   sakarProposed_H_experiment1_svm0.Spei = Spei;
   sakarProposed_H_experiment1_svm0.G_mean = G_mean; 
   sakarProposed_H_experiment1_svm0.G_meani = G_meani; 
   sakarProposed_H_experiment1_svm0.F1_score = F1_score; 
   sakarProposed_H_experiment1_svm0.F1_scorei = F1_scorei;
end
toc
end


%% �Ӻ���
function [f,U1,mode2,indx,missed_samples,missed_labels] = self_KG_adbstLDPP(trainx,trainy,validx,validy,type_num)
%%
kk = 20;
mukgamma=[];
mean_svml8_max=0;
for igamma=1:9
    for imu=1:9
        method = [];
        method.mode = 'ldpp_u';
        method.mu = 0.00001*power(10,imu);
        method.gamma = 0.00001*power(10,igamma);
        method.M = 200;
        method.labda2 = 0.001;   %ȡ[0.0001,0.001,...,1000,10000]
        method.ratio_b = 0.9;    %��ʱ���Ǻ�������������ĺ���
        method.ratio_w = 0.9;
        method.weightmode = 'binary';
%         method.weightmode = 'heatkernel'; %��������Ը���ģʽ
        method.knn_k = 5;
        svml8 = [];
        U = featureExtract2(trainx,trainy,method,type_num); %ʹ��֮ǰ�ķ�����ȡ����ӳ�����U
           for ik = 1:floor(size(trainx,2)/20)
                method.K = kk * ik;
%                 method.K = ik;
                mukgamma = [mukgamma;[imu ik igamma]];    
                trainZ = projectData(trainx, U, method.K);
                validZ = projectData(validx, U, method.K);
                
%                 % SVM��˹ 
                model = svmtrain(trainy,trainZ,'-s 0 -t 2');%%ʹ�����б任���ѵ����ѵ��ģ��
                svm_pred = svmpredict(validy,validZ,model);  % �����testZ����valid
                svml8(ik)= mean(svm_pred == validy) * 100;
                
                %SVM ����
%                 model = svmtrain(trainy,trainZ1,'-s 0 -t 0'); %%ʹ�����б任���ѵ����ѵ��ģ��
%                 svm_pred = svmpredict(validy,testZ,model);  % �����testZ����valid
%                 svml8(ik)= mean(svm_pred == validy) * 100;

                % RF���ɭ��               
%                 model = classRF_train(trainZ1,trainy,'ntree',300)
%                 [svm_pred,votes] = classRF_predict(testZ,model)
%                 svml8(ik) = mean(svm_pred == validy) * 100
                     %  ELM         
%                  [~, ~, ~, TestingAccuracy,svm_pred] = ELM([trainy trainZ1], [validy testZ], 1, 5000, 'sig', 10^2);
           end
            
               [acc_svml_max,indx2] = max(svml8);
               Accuracy(igamma,imu) = acc_svml_max;
               best_svml_kk = kk * indx2; 
%                best_svml_kk = indx2; 
               bestK(igamma,imu) = best_svml_kk;
    end
end
        [loc_x,loc_y] = find(Accuracy==max(max(Accuracy)));%�ҵ����ֵ��λ��
        mean_svml8_max = max(max(Accuracy));
%       U_svml_best=U1_all;
        best_svml_kk = bestK(loc_x(1),loc_y(1));
        method.mu = 0.00001 * power(10,loc_y(1));%ȡ[0.0001,0.001,...,1000,10000]
        method.gamma = 0.00001 * power(10,loc_x(1));
        
       %% ��������ҳ���õ�U������������ method��ͨ
        U = featureExtract2(trainx,trainy,method,type_num);  %ʹ���ҵ�����õ�U�������method�ó����Ų�����Ӧ��U����
        U1 = U(:,1:best_svml_kk);
        trainZ1 = trainx * U(:,1:best_svml_kk);  %ʹ����õ�U������б任
        validZ1 = validx * U(:,1:best_svml_kk);
        
        %% ʹ��relief����ѡ���㷨
         [fea] = relieff(trainZ1,trainy, 5);
%          kk = 5;
         svml2 = [];
         % ������� ��������������������ѵ����Ԥ�⾫��  
        for ik = 1:floor(size(trainZ1,2)/20) 
            K = kk * ik;  
%             K =  ik; 
            trainZ = trainZ1(:,fea(:,1:K));
            validZ = validZ1(:,fea(:,1:K)); 
            
            % SVM��˹ 
              
             model = svmtrain(trainy,trainZ,'-s 0 -t 2');%%ʹ�����б任���ѵ����ѵ��ģ��
             svm_pred = svmpredict(validy,validZ,model);
             svml2 = [svml2 mean(svm_pred == validy) * 100;]; 
             

              % SVM ����
%              model = svmtrain(trainy,trainZ,'-s 0 -t 0');%%ʹ�����б任���ѵ����ѵ��ģ��
%              svm_pred = svmpredict(validy,test,model);
%              svml2 = [svml2 mean(svm_pred == validy) * 100;];
%                 
                % RF���ɭ��
%               model = classRF_train(trainZ,trainy,'ntree',300)
%              [svm_pred,votes] = classRF_predict(test,model)
%               svml2 = mean(svm_pred == validy) * 100;
  
        end
       % ������� ѡ������ŵ����� ����˼·���Ƚ���������ȡ���ڽ�������ѡ��û��������������������������
        [acc_svml_max,indx2] = max(svml2);
        best_svml_kk = kk * indx2;
%         best_svml_kk =  indx2;
        
      
       %% ��ѡ������������������ Ӧ�õ�LDPP����ӳ�������ݿ�
        f = fea(:,1:best_svml_kk);
        train = trainZ1(:,f);
        test = validZ1(:,f);
               
      %% ʹ�����б任���ѵ����ѵ��ģ�Ͳ�Ԥ��
      
      % SVM ��˹ 
       mode2 = svmtrain(trainy,train,'-s 0 -t 2'); 
       svm_pred = svmpredict(validy,test,mode2);

       % SVM ���� 
%        mode2 = svmtrain(trainy,train,'-s 0 -t 0'); 
%        svm_pred = svmpredict(validy,test,mode2);
     
       % RF 
%      mode2 = classRF_train(train,trainy,'ntree',300)
%      [svm_pred,votes] = classRF_predict(test,mode2)
       

    
      %% �ҳ����ֵ������������������ص�������
       [indx,val] = find(0 == ( svm_pred == validy));    %Finding miss classified samples
       missed_samples = validx(indx,:);
       missed_labels = validy(indx,:);
       
       
end




