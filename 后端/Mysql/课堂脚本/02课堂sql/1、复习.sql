#һ�������ݿ���ص�DDL
#�鿴���ݿ�
show databases;

#�������ݿ�
create database ���ݿ���;
create database ���ݿ��� character set �ַ������� collate У�Թ���;

#ʹ�����ݿ�
use ���ݿ�����;

#�鿴���ݿ�Ķ���
show create database ���ݿ�����;

#�޸����ݿ⣬�����޸����ݿ�����ֻ���޸��ַ�����У�Թ���
create database ���ݿ��� character set �ַ������� collate У�Թ���;
/*
һ���⽨�꣬�����Ѿ������˱��
�������ʱû��ָ���ַ�����ʹ�����ݿ�Ĭ�ϵ��ַ����Ļ���
�����֮�����޸����ݿ���ַ�����У�Թ����ǱȽ��鷳�ģ�
��Ϊ���еı���ֶε��ַ�����У�Թ�����Ҫ�����޸ġ�

��������һ��ʼ��Ҫȷ�������ݿ���ַ�����У�Թ���
�ر���MySQL8֮ǰ��mysql������Ĭ�ϵ��ַ�����Latin1��
���û���޸������ļ�my.ini����ȥ�������ݿ⣬���ݿ�Ĭ��Ҳ��Latin1��
*/

#ɾ�����ݿ�
drop database ���ݿ���;


#���������ݱ���ص�DDL
#�鿴���б��
show tables; #ǰ����use���
show tables from ���ݿ���;

#�������
create table ������(
	�ֶ��� ��������,
	�ֶ��� ��������
);

create table ������(
	�ֶ��� ��������,
	�ֶ��� ��������
) character set �ַ������� collate У�Թ���;

#�鿴���Ķ���
show create table ������;

#�鿴��ṹ
desc ������;
describe ������;

#ɾ�����
drop table ������;

#�޸ı�����
rename table �ɱ��� to �±���;
alter table �ɱ��� rename ��to�� �±���;

alter table `my tab` rename to mytab;
alter table `mytab` rename mytable;
rename table mytable to mytab;

#�޸ı��ַ�����У�Թ���
alter table ������ character set �ַ������� collate У�Թ���;

#�����ֶ�
alter table ������ add ��column�� ���ֶ��� ��������;
alter table ������ add ��column�� ���ֶ��� �������� first;
alter table ������ add ��column�� ���ֶ��� �������� after �ֶ���;

#ɾ���ֶΣ���ͬ���ֶε���������һ��ɾ�����൱�ڰѱ���ĳ�еĽṹ������һ��ɾ��
alter table ������ drop ��column�� �ֶ���;

#�޸��ֶε��������͡�λ��
alter table ������ modify ��column�� �ֶ��� ��������;
alter table ������ modify ��column�� �ֶ��� �������� first;
alter table ������ modify ��column�� �ֶ��� �������� after �ֶ���;

#�޸��ֶε�����
alter table ������ change ��column�����ֶ��� ���ֶ��� ��������;

#�޸��ֶε��ַ�����У�Թ���
alter table ������ modify ��column�� �ֶ��� �������� character set �ַ������� collate У�Թ���;

#����DML
#1����Ӽ�¼
#��Ӽ�¼�������ڼ�¼�м���루�൱��ѧϰIO����׷��ģʽ��
#�����Ҫ��˳�򿴽������Ҫ�ڲ�ѯʱ��xx����������Ч����
insert into ������ values(ֵ�б�); 
#Ҫ��(ֵ�б�)��ֵ��������˳���������ṹ�ֶε�������˳������һһ��Ӧ��
#���ַ�ʽ�������ṹ���ֶε�˳�������б仯����ô���insert�ű���Ҫ�޸ġ�

insert into ������(�ֶ��б�) values(ֵ�б�); #�Ƽ�ʹ����������ȶ�
#Ҫ��(ֵ�б�)��ֵ��������˳������������ƺ���(�ֶ��б�)��������˳������һһ��Ӧ��
#���ַ�ʽ�������ṹ���ֶε�˳�����ӣ���ô���insert�ű������޸ġ�
#���ַ�ʽ�������ṹ�а�(�ֶ��б�)�ֶε����Ʊ��ˡ�ɾ���ֶΣ���ô���insert�ű���Ҫ�޸ġ�

insert into ������ values(ֵ�б�),(ֵ�б�),(ֵ�б�)....; 
insert into ������(�ֶ��б�) values(ֵ�б�),(ֵ�б�),(ֵ�б�)....; 

#2���޸ļ�¼
#�޸������е��ֶ�1���ֶ�2��ֵ����������
update ������ set �ֶ���1 = ֵ, �ֶ���2 = ֵ ....;

#�޸�����where�������е��ֶ�1���ֶ�2��ֵ����������
update ������ set �ֶ��� = ֵ, �ֶ��� = ֵ .... where ����; 


#3��ɾ���м�¼��ֻҪdeleteһ����ɾ�����У�
#ɾ������where��������
delete from ������ where ����;

#ɾ��������������
delete from ������;
truncate ������;

truncate :�죬��֧������
delete������֧������