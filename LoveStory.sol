pragma solidity 0.4.24;

contract LoveStore {
    
    //时间链结点
    struct link{
        uint256 time;
        uint8 Type;
    }
    
    mapping (address => uint256[]) private sec_cate;
    mapping (address => uint256[]) private pro_cate;
    mapping (address => uint256[]) private ann_cate;
    mapping (address => uint256[]) private dia_cate;
    mapping (address => link[]) private categories;
    //添加到时间链
    
    function addtosec(address from,uint256 time) private
    {
        sec_cate[from].push(time);
    }
    
    function addtopro(address from,uint256 time) private
    {
        pro_cate[from].push(time);
    }
    
    function addtoann(address from,uint256 time) private
    {
        ann_cate[from].push(time);
    }
    
    function addtodia(address from,uint256 time) private
    {
        dia_cate[from].push(time);
    }
    
    function getsec(address from) public view returns (uint256[]){
        return sec_cate[from];
    }
    
    function getpro(address from) public view returns (uint256[]){
        return pro_cate[from];
    }
    
    function getann(address from) public view returns (uint256[]){
        return ann_cate[from];
    }
    
    function getdia(address from) public view returns (uint256[]){
        return dia_cate[from];
    }
    
    function addtoList(address from,uint256 time, uint8 Type)
    {
        link node;
        node.time=time;
        node.Type=Type;
        categories[from].push(node);
    }
    function getalltime(address from) public view returns (uint256[]){
        uint256[] timelist;
        uint leng = categories[from].length;
        
        for(uint i = 0; i < leng; i++)
        {
            timelist.push(categories[from][i].time);
        }
        
        return timelist;
    }
    function getalltype(address from) public view returns (uint8[]){
        uint8[] Tpyelist;
        uint leng = categories[from].length;
        
        for(uint i = 0; i < leng; i++)
        {
            Tpyelist.push(categories[from][i].Type);
        }
        
        return Tpyelist;
    }
    
    //测试
    function test2(bytes aaa) constant returns(bytes1){
        bytes1 te = aaa[0];
        return te;
        
        //return ts;
        //return string(ts);
    }
    
    //测试
    function test(string text) public view returns(string){
        bytes memory tb = bytes(text);
        string memory ret = new string(tb.length);
        bytes memory ts = bytes(ret);
        uint k = tb.length - 1;
        for (uint i = 0; i < tb.length ; i++)
        {
            ts[k] = tb[i];
            k--;
        }
        return string(ts);
    }
    
    
    //加密
    function mys(string text) constant returns(string){
        bytes memory tb = bytes(text);
        string memory ret = new string(tb.length);
        bytes memory ts = bytes(ret);
        uint k = tb.length - 1;
        for (uint i = 0; i < tb.length ; i++)
        {
            ts[k] = tb[i];
            k--;
        }
        return string(ts);
    }
    //存储一对情侣信息
    struct Addrlover{
        address boy;
        address girl;
        bool islover;//是否是情侣
    }
    Addrlover[] addr;//存储所有情侣
    //发出请求
    function addrequire(address boy, address girl) private {
        Addrlover storage test;
        test.boy = boy;
        test.girl = girl;
        test.islover = false;
        addr.push(test);
    }
    //接受请求列表
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
    //确认请求
    function confrequire(address boy, address girl) private {
        for(uint i = 0; i < addr.length; i++)
        {
            if( addr[i].boy == boy && addr[i].girl == girl)
            {
                addr[i].islover == true;
            }
        }
    }
    //返回对方地址
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
    
    //承诺结构体
    struct Promise{
        bool can_see;
        string text;
    }
    //纪念日结构体
    struct anniversary
    {
        uint256 time;
        string ann_name ;
    }
    mapping (address => mapping (uint256 => string)) private secerts;//秘密
    mapping (address => mapping (uint256 => Promise)) private promises;//承诺
    mapping (address => anniversary[]) private anniversarys;//纪念日
    mapping (address => mapping (uint256 => string)) private diarys;//手账

    
    //secerts 1
    //add secert
    function add_sec(string text, address from, uint256 time) public {
        secerts[from][time]=mys(text);
        addtoList(from, time, 1);
        addtosec(from, time);
    }
    //get secert 
    function get_sec(address from, uint256 time) public view returns(string) {
        if(msg.sender == from || cp(from)==msg.sender)
            return mys(secerts[from][time]);
        else return "you have not the rights";
    }

    //promises 2
    //add promise
    function add_pro(string text, address from, uint256 time,bool canSee) public {
        if(canSee==false)
        {
            promises[from][time].text=mys(text);
            
        }
        else promises[from][time].text=text;
        promises[from][time].can_see=canSee;
        addtoList(from, time, 2);
        addtopro(from, time);
        //emit Recorded(msg.sender, text, time);
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

    //anniversarys 3
    //add anniversary
    function add_ann(address from, uint256 time, string name) public {
        anniversary sh;
        sh.time=time;
        sh.ann_name=name;
        anniversarys[from].push(sh);
        addtoList(from, time, 3);
        addtoann(from, time);
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

    //diarys 4
    //add diary
    function add_dia(string text, address from, uint256 time) public {
        diarys[from][time]=text;
        addtoList(from, time, 4);
        addtodia(from, time);
    }
    //get diary
    function get_dia(address from, uint256 time) public view returns(string) {
        return diarys[from][time];
    }
    //ding shi
    

    



}