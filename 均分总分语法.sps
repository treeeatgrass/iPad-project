* Encoding: UTF-8.

DATASET ACTIVATE 数据集10.
COMPUTE 网络游戏成瘾均分=MEAN(@5、1.我玩网游的时间比我预期的要长,@5、2.我花很多时间玩网游而减少了与家人和朋,@5、3.相对于现实的朋友，我与网游里的朋友更,
    @5、4.我会与其他网游玩家建立新的良好关系,@5、5.生活中朋友、家人会抱怨我玩网游的时间,@5、6.网游占据大量时间，我的作业和学习成绩,@5、7.我会不顾身边需要解决的一些问题而先玩,
    @5、8因为玩网游，我的工作成绩和效率受到影响,@5、9.我会通过撒谎来隐瞒我玩网游的时间,@5、10.网游可以使我忘却生活里烦躁的想法,@5、11.不能玩网游的时候我总是期望我能玩,
    @5、12.我害怕不能玩网游而带来的无聊、空虚、,@5、13.当有人打扰了我玩网游的时候，我会很生,@5、14.我常深夜玩网游而不睡觉,@5、15.没玩网游时，我心里总想着游戏或者幻想,
    @5、16.玩网游时对自己说“再玩一小会儿就行”,@5、17.我尝试减少玩网游的时间却以失败告终,@5、18.我总想隐瞒我玩游戏的时间,@5、19.我宁愿选择花更多的时间玩网游而不是和,
    @5、20.不玩网游时我会感到沮丧、烦躁或情绪低).
EXECUTE.



DATASET ACTIVATE 数据集6.
COMPUTE 手机成瘾均分=MEAN(@12、因使用智能手机错过计划的工作。,@12、因使用智能手机在课堂上完成作业或工作时,@12、使用智能手机时感觉到手腕或脖子的后面疼,
    @12、不能忍受没有智能手机。,@12、当我没有拿到智能手机时会感到焦躁不安。,@12、即使没有使用时，也会在脑海中想着我的智,@12、即使日常生活受到严重影响，我也不会放弃,
    @12、因为担心错过和他人的微信、QQ等社交网站,@12、比原计划更多地使用了智能手机。,@12、身边的人曾提醒我过多地使用了智能手机。).
EXECUTE.

COMPUTE PANAS_POS=MEAN(@11、有兴趣的,@11、警觉的,@11、兴奋的,@11、鼓舞的,@11、强烈的,@11、有决心的,@11、关怀的,@11、热忱的,@11、活跃的,
    @11、骄傲的).
EXECUTE.

COMPUTE PANAS_NEG=MEAN(@11、激惹的,@11、痛苦的,@11、羞愧的,@11、难过的,@11、紧张的,@11、内疚的,@11、惊恐的,@11、敌对的,@11、神经质的,
    @11、害怕的).
EXECUTE.

RECODE @4、WhichreactiondoesAkiramostfearfromChie (1=1) (SYSMIS=SYSMIS)(ELSE=0) INTO SAT_4.
EXECUTE.

RECODE @1、Whichchoicebestdescribeswhathappensinthepassage 
    @2、Whichchoicebestdescribesthedevelopmentalpatternofthe @8、Asusedinline2“form”mostnearlymeans 
    @10、Whichchoiceprovidesthebestevidencefortheanswertot (2=1) (SYSMIS=SYSMIS)(ELSE=0) INTO SAT_1 SAT_2 SAT_8 SAT_10.
EXECUTE.

RECODE @3、Asusedinline1andline65directlymostnearlymeans 
    @5、Whichchoiceprovidesthebestevidencefortheanswertoth 
    @9、WhydoesAkirasayhismeetingwithChieis“amatterofu (3=1) (SYSMIS=SYSMIS)(ELSE=0) INTO SAT_3 SAT_5 SAT_9.
EXECUTE.

RECODE @6、InthepassageAkiraaddressesChiewith @7、Themainpurposeofthefirstparagraphisto (4=1) 
    (SYSMIS=SYSMIS)(ELSE=0) INTO SAT_6 SAT_7.
EXECUTE.

DATASET ACTIVATE 数据集1.
COMPUTE LL=MEAN(LL7,LL17,LL19,LL34,LL37,LL53).
COMPUTE LM=MEAN(LM6,LM15,LM24,LM36,LM39,LM47).
COMPUTE LR=MEAN(LR8,LR10,LR27,LR29,LR44,LR52).
COMPUTE ML=MEAN(ML5,ML12,ML22,ML28,ML45,ML51).
COMPUTE MM=MEAN(MM3,MM16,MM26,MM35,MM42,MM46).
COMPUTE MR=MEAN(MR1,MR11,MR23,MR33,MR38,MR54).
COMPUTE RL=MEAN(RL9,RL14,RL20,RL31,RL40,RL48).
COMPUTE RM=MEAN(RM4,RM13,RM21,RM32,RM43,RM49).
COMPUTE RR=MEAN(RR2,RR18,RR25,RR30,RR41,RR50).
EXECUTE.

DATASET ACTIVATE 数据集5.
COMPUTE rightRoute=SUM(MR1,RR2,MM3,RM4,ML5,LM6,LL7,LR8,RL9,LR10,MR11,ML12,RM13,RL14,LM15,MM16,LL17,
    RR18,LL19,RL20,RM21,ML22,MR23,LM24,RR25,MM26,LR27,ML28,LR29,RR30,RL31,RM32,MR33,LL34,MM35,LM36,LL37,
    MR38,LM39,RL40,RR41,MM42,RM43,LR44,ML45,MM46,LM47,RL48,RM49,RR50,ML51,LR52,LL53,MR54).
EXECUTE.

DATASET ACTIVATE 数据集6.
RECODE VAR00002 (11 thru 43=2) (Lowest thru 11=1) (43 thru Highest=3) INTO routeVariation.
EXECUTE.

DATASET ACTIVATE 数据集7.
COMPUTE L=MEAN(LL,ML,RL).
EXECUTE.

COMPUTE M=MEAN(LM,MM,RM).
EXECUTE.

COMPUTE R=MEAN(LR,MR,RR).
EXECUTE.

DATASET ACTIVATE 数据集2.
COMPUTE SATdetail=SUM(SAT_8,SAT_10,SAT_3,SAT_9,SAT_7).
COMPUTE SATabstract=SUM(SAT_1,SAT_2,SAT_4,SAT_5,SAT_6).
EXECUTE.
