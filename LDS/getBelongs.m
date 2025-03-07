function [n1_bl,n2_bl] = getBelongs(n1,n2,number)
%number is the chosed id from the features combination of n1*n2*n3 format.

check1 = number > n1*n2;
check2 = number < 1;
if sum(check1(:)) || sum(check2(:))
    fprintf('the input number %d is out of range.\n',number(find(number>n1*n2*n3)),number(find(number<1)));
end

% �õ�����colorspace��ţ����Ƿֶε�
n1_bl = floor((number-1)/(n2))+1;
% �õ�����ica��ţ���������ѭ���ġ��ȷֶΣ���ֱ��ȡ��
n2_bl = floor((number-1))+1;
n2_bl = mod(n2_bl,n2);
% �õ�����gbvs��һά������ֱ�ӵġ�
n2_bl((n2_bl==0)) = n2;

n1_bl = n1_bl(:);
n2_bl = n2_bl(:);