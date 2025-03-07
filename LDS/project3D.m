function [proRlt] = project3D(base,pic_path,mean_v,std_v)
if mod(size(base,2),3) ~= 0
    fprintf('project3D��base should be divided by 3\n');
end


if size(pic_path,1)~=1
    img = im2double(pic_path);
else
    img = im2double( imread(pic_path) );
end

if size(img,3)==1
    fprintf('project3D��we need a picture in 3D structure, not a 2D gray map\n');
end

nSideLen = sqrt( size(base,2)/3 );
nSubSpsNum = size(base,1);
h = floor(size(img,1)/nSideLen);
w = floor(size(img,2)/nSideLen);

proRlt = zeros(h,w,nSubSpsNum);
% �û��ֵķ�ʽ�õ����ɸ�8*8��С��Patch����PatchͶӰ���õ�proj
if nargin == 2 % ��ӳ��֮ǰ��ʲô����������
    for p = 1:h
        for q = 1:w
            patch = img((p-1)*nSideLen+1:p*nSideLen,(q-1)*nSideLen+1:q*nSideLen,:);
            pv = base*patch(:);
            proRlt(p,q,:)=pv;
        end
    end
else % ��ӳ��֮ǰ��Ҫ��ȥ��ֵ�����Է��
    %base = base./repmat(std_v,size(base,1),1);
    for p = 1:h
        for q = 1:w
            patch = img((p-1)*nSideLen+1:p*nSideLen,(q-1)*nSideLen+1:q*nSideLen,:);
            pv = base*((patch(:)-mean_v(:))./std_v(:));
            proRlt(p,q,:)=pv;
        end
    end
end