function explain_glms
 
global theWindow W H window_ratio  %window property
global lb rb scale_W scale_H anchor_lms  %rating scale
global bgcolor white orange red  %color
 
% Explain gLMS with visualization
    
    while true % space
        DrawFormattedText(theWindow, double('�� ���� : �����ڴ� �� ����� ���� ����� ������ ��, �����̽��ٸ� �����ֽñ� �ٶ��ϴ�.'), 'center', H*(1/4), white, [], [], [], 2);
        Screen('DrawLine', theWindow, white, lb, H*(5/8), rb, H*(5/8), 4); %rating scale
        % penWidth: 0.125~7.000
        for i = 2:5
            Screen('DrawLine', theWindow, white, anchor_lms(1,i), H*(5/8)-scale_H/4, anchor_lms(1,i), H*(5/8)+scale_H/4, 2);
            Screen('DrawLine', theWindow, white, anchor_lms(2,i), H*(5/8)-scale_H/4, anchor_lms(2,i), H*(5/8)+scale_H/4, 2);
        end
        DrawFormattedText(theWindow, double('����'), lb-26, H*(5/8)+scale_H/1.2, white);
        DrawFormattedText(theWindow, double('����'), rb-26, H*(5/8)+scale_H/1.2, white);
        DrawFormattedText(theWindow, double('�߸�'), W/2-26, H*(5/8)+scale_H);
        Screen('DrawLine', theWindow, white, W/2, H*(5/8)-scale_H/3, W/2, H*(5/8)+scale_H/3, 6);
        Screen('DrawLine', theWindow, white, lb, H*(5/8)-scale_H/2, lb, H*(5/8)+scale_H/2, 6);
        Screen('DrawLine', theWindow, white, rb, H*(5/8)-scale_H/2, rb, H*(5/8)+scale_H/2, 6);
        
        %         DrawFormattedText(theWindow, double('���� �������� ����'), anchor_lms(1,1)-scale_W/5, H*(5/8)+scale_H/4, white,2,[],[],1);
        DrawFormattedText(theWindow, double('����'), anchor_lms(1,2)-scale_W/6, H*(5/8)+scale_H/2, white);
        DrawFormattedText(theWindow, double('�߰�'), anchor_lms(1,3)-scale_W/6, H*(5/8)+scale_H/2, white);
        DrawFormattedText(theWindow, double('����'), anchor_lms(1,4)-scale_W/6, H*(5/8)+scale_H/2, white);
        DrawFormattedText(theWindow, double('�ſ� ����'), anchor_lms(1,5)-scale_W/6, H*(5/8)+scale_H/2, white, 2,[],[],1);
        
        %         DrawFormattedText(theWindow, double('���� �������� ����'), anchor_lms(2,1), H*(5/8)+scale_H/4, white,2,[],[],1);
        DrawFormattedText(theWindow, double('����'), anchor_lms(2,2)-scale_W/6, H*(5/8)+scale_H/2, white);
        DrawFormattedText(theWindow, double('�߰�'), anchor_lms(2,3)-scale_W/6, H*(5/8)+scale_H/2, white);
        DrawFormattedText(theWindow, double('����'), anchor_lms(2,4)-scale_W/6, H*(5/8)+scale_H/2, white);
        DrawFormattedText(theWindow, double('�ſ� ����'), anchor_lms(2,5)-scale_W/6, H*(5/8)+scale_H/2, white, 2,[],[],1);
        
        Screen('Flip', theWindow);
        
        
        [~,~,keyCode] = KbCheck;
        if keyCode(KbName('space')) == 1
            break
        elseif keyCode(KbName('q')) == 1
            abort_experiment('manual');
        end
    end
    
    
end
