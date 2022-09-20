/*
�Ƚ��������
1������	>
2��С��	<
3�����ڵ��� >=
4��С�ڵ��� <=
5������  =
��MySQL�бȽ��Ƿ����Ҳ���õ��Ⱥţ�û��˫�Ⱥš�

6�������� !=  ��  <>

7����ȫ����<=>

8��is null��is not null

MySQL��NULL���жϺͼ������⣺
�ж���<=> null ��is null Ϊ���ж�
�ж���is not null �ǿ��ж�

9�����Ϸ�Χ�ķ�Χ
in (ֵ�б�)  �� not in(ֵ�б�)
ÿһ��ֵ�ö��ŷָ�

10�����䷶Χ���ж�
between xx and yy  �� not between xx and yy
between xx and yy��[xx,yy]
not between xx and yy�� <xx || >yy

11��like ģ����ѯ
like���ͨ���_��%ʹ��
_��һ���»��ߴ���һλ�ַ�
%��һ��%�����������0����n�����ַ�


*/

#��ѯн�ʸ���15000��Ա��������н��
select ename,salary from t_employee where salary>15000;

mysql> select ename,salary from t_employee where salary>15000;
+--------+--------+
| ename  | salary |
+--------+--------+
| ����� |  28000 |
| �ֱ��� |  15700 |
| �Ʊ��� |  15678 |
| ����� |  18760 |
| л���� |  18978 |
| ��俸� |  16788 |
| �¼��� |  15099 |
+--------+--------+
7 rows in set (0.00 sec)

#��ѯн��������9000��Ա��������н��
select ename,salary from t_employee where salary = 9000;
select ename,salary from t_employee where salary == 9000;#���󣬲�֧��==

mysql> select ename,salary from t_employee where salary == 9000;
ERROR 1064 (42000): You have an error in your SQL syntax;
 check the manual that corresponds to your MySQL server version for the right syntax to use near '== 9000' at line 1


#��ѯԱ�����в��ű�Ų���1
select * from t_employee where did != 1;
select * from t_employee where did <> 1;

#��ѯ���������NULL
select * from t_employee where commission_pct = null; 

mysql> select * from t_employee where commission_pct = null; #�޷���=null�ж�
Empty set (0.00 sec)
#mysql��ֻҪ��nullֵ��������ͱȽϣ��������null���ײ����0����ʾ������������

#��ѯ���������NULL
select * from t_employee where commission_pct <=> null; 
select * from t_employee where commission_pct is null; 


#��ѯ�����������������ɡ��������׷塱�⼸��Ա������Ϣ
select * from t_employee where ename in ('�����','�����','���׷�');

#��ѯ���ű��Ϊ2��3��Ա����Ϣ
select * from t_employee where did in(2,3);

#��ѯ���ű�Ų���2��3��Ա����Ϣ
select * from t_employee where did not in(2,3);

#��ѯн����[10000,15000]֮��
select * from t_employee where salary between 10000 and 15000;


#��ѯ�����еڶ�������'��'��Ա��
select * from t_employee where ename like '��'; #��ôд�ȼ��� ename='��'
select * from t_employee where ename like '_��%'; 
#��ôдƥ����ǵڶ������Ǳ����������û�е������֣������кü�����

update t_employee set ename = '����' where ename = '�����';

select * from t_employee where ename like '_��_'; 
#��ôдƥ����ǵڶ������Ǳ��������е������֣���ֻ��������


#��ѯԱ����������н�ʡ����������ʵ������
#ʵ������ = н�� + н�� * �������
select ename as ����,
salary as н��,
commission_pct as �������,
salary + salary * commission_pct as ʵ������
from t_employee;

#NULL��mysql�бȽϺͼ��㶼�������ԣ����еļ���������null����null��
#ʵ������ = н�� + н�� * �������
select ename as ����,
salary as н��,
commission_pct as �������,
salary + salary * ifnull(commission_pct,0) as ʵ������
from t_employee;


