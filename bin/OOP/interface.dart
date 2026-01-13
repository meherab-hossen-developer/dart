void main(){

  var tv = Television();
  tv.volumeUp();
  tv.volumeDown();
}

class Remote{

  void volumeUp(){

    print('__Volume up from remote');
  }
  void volumeDown(){

    print('Volume down from remote');
  }
}

class Television implements Remote{

  void volumeUp(){

    print('Volume up in television');
  }
  void volumeDown(){

    print('Volume down in television');
  }
}