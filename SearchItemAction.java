package com.internousdev.florida.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.interceptor.SessionAware;

import com.internousdev.florida.dao.MCategoryDAO;
import com.internousdev.florida.dao.ProductInfoDAO;
import com.internousdev.florida.dto.MCategoryDTO;
import com.internousdev.florida.dto.ProductInfoDTO;
import com.internousdev.florida.util.InputChecker;
import com.opensymphony.xwork2.ActionSupport;

public class SearchItemAction extends ActionSupport implements SessionAware{
    private String categoryId;
	private String keywords;
	private List<String> keywordsErrorMessageList;
	private List<ProductInfoDTO> productInfoDTOList;
	private Map<String, Object> session;

	public String execute() {

		// カテゴリーの選択肢が存在しない場合は、すべてのカテゴリーを設定する
		//商品ID使う
		if (categoryId == null) {
			categoryId = "1";
		}

		InputChecker inputChecker = new InputChecker();

		// 処理用の変数に値を入れる
		if (StringUtils.isBlank(keywords)){
			//キーワードが null,""," ","　"の時に空文字に設定する
			keywords = "";
		}else{
			//replaseALLは左を右にしている。"　"を" "にしている
			//下のsplitで文字ごとに分ける時に"　"だと文字として切れなくなるので変換してくれている
			keywords = keywords.replaceAll("　", " ").replaceAll("\\s{2,}", " ").trim();
			                                                   //特殊文字
		}

		if(!keywords.equals("")){
			keywordsErrorMessageList = inputChecker.doCheck("検索ワード", keywords,0,50, true, true, true, true, true, true);

			if (keywordsErrorMessageList.size() > 0) {
				return SUCCESS;
			}
		}

		ProductInfoDAO productInfoDAO = new ProductInfoDAO();
		switch (categoryId) {
		case "1":
			productInfoDTOList = productInfoDAO.getProductInfoListByKeyword(keywords.split(" "));
			break;

		default:
			productInfoDTOList = productInfoDAO.getProductInfoListByCategoryIdAndKeyword(keywords.split(" "), categoryId);
			break;
		}

		// カテゴリーのリストが表示されていないのは良くないので、作成する
		if(!session.containsKey("mCategoryDTOList")) {
			List<MCategoryDTO> mCategoryDTOList = new ArrayList<MCategoryDTO>();
			MCategoryDAO mCategoryDAO = new MCategoryDAO();
			try {
				mCategoryDTOList = mCategoryDAO.getMCategoryList();
			} catch (NullPointerException e) {
				mCategoryDTOList = null;
			}
			session.put("mCategoryDTOList", mCategoryDTOList);
		}

		return SUCCESS;
	}

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	public List<String> getKeywordsErrorMessageList() {
		return keywordsErrorMessageList;
	}

	public void setKeywordsErrorMessageList(List<String> keywordsErrorMessageList) {
		this.keywordsErrorMessageList = keywordsErrorMessageList;
	}

	public List<ProductInfoDTO> getProductInfoDTOList() {
		return productInfoDTOList;
	}

	public void setProductInfoDTOList(List<ProductInfoDTO> productInfoDTOList) {
		this.productInfoDTOList = productInfoDTOList;
	}

	public Map<String, Object> getSession() {
		return session;
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

}
