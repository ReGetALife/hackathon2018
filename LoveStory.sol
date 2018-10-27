pragma solidity 0.4.24;

contract LoveStory {
    
    //����
    function testabi(string text) constant returns(bytes){
        bytes memory tb = bytes(text);
        bytes memory ts;
        uint k = 0;
        
        for (uint i = 0; i < tb.length; i++)
            ts[k++] = tb[i];
        
        return tb;
        //return string(ts);
    }
    
    
    //����
    function mys(string text) constant returns(string){
        bytes memory tb = bytes(text);
        bytes memory ts;
        uint k = 0;
        for (uint i = tb.length - 1; i >= 0; i--)
            ts[k++] = tb[i];
        return string(ts);
    }
    //�洢һ��������Ϣ
    struct Addrlover{
        address boy;
        address girl;
        bool islover;//�Ƿ�������
    }
    Addrlover[] addr;//�洢��������
    //��������
    function addrequire(address boy, address girl) private {
        Addrlover storage test;
        test.boy = boy;
        test.girl = girl;
        test.islover = false;
        addr.push(test);
    }
    //���������б�
    function getrequire(address to, bool sexy) public view returns(address[]){
        address[] addrlist;
        for(uint i = 0; i < addr.length; i++)
        {
            if( sexy == false && addr[i].girl == to)
            {
                addrlist.push(addr[i].boy);
            }
            else if( sexy == true && addr[i].boy == to)
            {
                addrlist.push(addr[i].girl);
            }
        }
        return addrlist;
    }
    //ȷ������
    function confrequire(address boy, address girl) private {
        for(uint i = 0; i < addr.length; i++)
        {
            if( addr[i].boy == boy && addr[i].girl == girl)
            {
                addr[i].islover == true;
            }
        }
    }
    //���ضԷ���ַ
    function cp(address from) public view returns(address) {
        for(uint i = 0; i < addr.length; i++)
        {
            if( addr[i].boy == from && addr[i].islover ==true)
            {
                return addr[i].girl;
            }
            else if( addr[i].girl == from && addr[i].islover ==true)
            {
                return addr[i].boy;
            }
        }
    }
    
    //��ŵ�ṹ��
    struct Promise{
        bool can_see;
        string text;
    }
    //�����սṹ��
    struct anniversary
    {
        uint256 time;
        string ann_name ;
    }
    mapping (address => mapping (uint256 => string)) private secerts;//����
    mapping (address => mapping (uint256 => Promise)) private promises;//��ŵ
    mapping (address => anniversary[]) private anniversarys;//������
    mapping (address => mapping (uint256 => string)) private diarys;//����

    event Recorded(address _sender, string indexed _text, uint256 indexed _time);

    //secerts
    //add secert
    function add_sec(string text, address from, uint256 time) public {
        secerts[from][time]=mys(text);
        emit Recorded(from, text, time);
    }
    //get secert 
    function get_sec(address from, uint256 time) public view returns(string) {
        if(msg.sender == from || cp(from)==msg.sender)
            return mys(secerts[from][time]);
        else return "you have not the rights";
    }

    //promises
    //add promise
    function add_pro(string text, address from, uint256 time,bool canSee) public {
        if(canSee==false)
        {
            promises[from][time].text=mys(text);
            
        }
        else promises[from][time].text=text;
        promises[from][time].can_see=canSee;
        emit Recorded(msg.sender, text, time);
    }
    //get promise
    function get_pro(address from, uint256 time) public view returns(string) {
        if(promises[from][time].can_see==false)
        {
            if(msg.sender == from || cp(from)==msg.sender)
                return mys(promises[from][time].text);
            else return "you have not the rights";
        }
        else return promises[from][time].text;
    }

    //anniversarys
    //add anniversary
    function add_ann(address from, uint256 time, string name) public {
        anniversary sh;
        sh.time=time;
        sh.ann_name=name;
        anniversarys[from].push(sh);
    }
    //get anniversary time and name
    function get_anntime(address from,uint256 time) public view returns(uint) {
        anniversary thenew;
        thenew.time=0;
        for(uint k=0;k<anniversarys[from].length;k++)
        {
            if(anniversarys[from][k].time>time && thenew.time<anniversarys[from][k].time)
            thenew=anniversarys[from][k];
        }
        if(thenew.time==0)
          return 0;
        else return thenew.time;
    }
    function get_annname(address from,uint256 time) public view returns(string) {
        anniversary thenew;
        thenew.time=0;
        for(uint k=0;k<anniversarys[from].length;k++)
        {
            if(anniversarys[from][k].time>time && thenew.time<anniversarys[from][k].time)
            thenew=anniversarys[from][k];
        }
        if(thenew.time==0)
          return "nothing";
        else return thenew.ann_name;
        
        
    }

    //diarys
    //add diary
    function add_dia(string text, address from, uint256 time) public {
        diarys[from][time]=text;
        emit Recorded(msg.sender, text, time);
    }
    //get diary
    function get_dia(address from, uint256 time) public view returns(string) {
        return diarys[from][time];
    }
    //ding shi
    

    



}