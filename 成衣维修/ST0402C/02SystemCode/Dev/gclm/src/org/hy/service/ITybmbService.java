package org.hy.service;

import java.util.List;

import org.hy.model.Tybmb;

public interface ITybmbService {
	public List<Tybmb> queryTybmb(String whereHQL);
	public void saveEntity(Tybmb entity);
	public void updateEntity(Tybmb entity);
	public void deleteEntityByID(String id);
}
