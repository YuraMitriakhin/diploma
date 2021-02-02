package com.gmail.yuramitryahin.config;

import com.gmail.yuramitryahin.entity.user.User;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

public class ListOnlineUsers {
    private static volatile ListOnlineUsers instance;
    private List<User> list;

    private  ListOnlineUsers(){
        this.list=new CopyOnWriteArrayList();
    }

    public  static ListOnlineUsers getInstance(){
        if(instance==null)
        synchronized (ListOnlineUsers.class){
            if (instance==null){
                instance=new ListOnlineUsers();
            }
        }
        return instance;

    }
}
