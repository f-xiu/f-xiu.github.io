#��ʾ�߼������
/*
�߼��������
1���룺&&  and
2����||  or
3���ǣ�!   not
4���߼����xor

λ�������&��|��^��>>��
*/
#��ѯн�ʸ���15000�������Ա����е�Ա��
select * from t_employee where salary>15000 and gender='��';
select * from t_employee where salary>15000 && gender='��';

select * from t_employee where salary>15000 & gender='��';#���� &��λ��
select * from t_employee where (salary>15000) & (gender='��');

#��ѯн�ʸ���15000������didΪ1��Ա��
select  * from t_employee where salary>15000 or did = 1;
select  * from t_employee where salary>15000 || did = 1;

#��ѯн�ʲ���[15000,20000]��Χ��
select  * from t_employee where salary not between 15000 and 20000;
select  * from t_employee where !(salary between 15000 and 20000);

#��ѯн�ʸ���15000������didΪ1��Ա��������ֻ��������һ
select  * from t_employee where salary>15000 xor did = 1;
select  * from t_employee where (salary>15000) ^ (did = 1);
