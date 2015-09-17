package mx.amib.sistemas.external.membership;

import java.util.Date;

public class UserTO {
	private long id;
	private String uuid;
	
	private String userName;
	private String userNameLowercase;
	private Date lastActivity;
	private String password;
	private String passwordFormat;
	private String passwordSalt;
	
	private String email;
	private String emailLowercase;
	
	private String passwordQuestion;
	private String passwordAnswer;
	
	private boolean isApproved;
	private Date lastLogin;
	private Date lastPasswordChange;
	
	private boolean isLockedOut;
	private Date lastLockedOut;
	
	private int failedAttempts;
	private int failedAnswerAttempts;
	
	private String comment;
	
	private Date createdDate;

	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserNameLowercase() {
		return userNameLowercase;
	}

	public void setUserNameLowercase(String userNameLowercase) {
		this.userNameLowercase = userNameLowercase;
	}

	public Date getLastActivity() {
		return lastActivity;
	}

	public void setLastActivity(Date lastActivity) {
		this.lastActivity = lastActivity;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPasswordFormat() {
		return passwordFormat;
	}

	public void setPasswordFormat(String passwordFormat) {
		this.passwordFormat = passwordFormat;
	}

	public String getPasswordSalt() {
		return passwordSalt;
	}

	public void setPasswordSalt(String passwordSalt) {
		this.passwordSalt = passwordSalt;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmailLowercase() {
		return emailLowercase;
	}

	public void setEmailLowercase(String emailLowercase) {
		this.emailLowercase = emailLowercase;
	}

	public String getPasswordQuestion() {
		return passwordQuestion;
	}

	public void setPasswordQuestion(String passwordQuestion) {
		this.passwordQuestion = passwordQuestion;
	}

	public String getPasswordAnswer() {
		return passwordAnswer;
	}

	public void setPasswordAnswer(String passwordAnswer) {
		this.passwordAnswer = passwordAnswer;
	}

	public boolean isApproved() {
		return isApproved;
	}

	public void setApproved(boolean isApproved) {
		this.isApproved = isApproved;
	}

	public Date getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(Date lastLogin) {
		this.lastLogin = lastLogin;
	}

	public Date getLastPasswordChange() {
		return lastPasswordChange;
	}

	public void setLastPasswordChange(Date lastPasswordChange) {
		this.lastPasswordChange = lastPasswordChange;
	}

	public boolean isLockedOut() {
		return isLockedOut;
	}

	public void setLockedOut(boolean isLockedOut) {
		this.isLockedOut = isLockedOut;
	}

	public Date getLastLockedOut() {
		return lastLockedOut;
	}

	public void setLastLockedOut(Date lastLockedOut) {
		this.lastLockedOut = lastLockedOut;
	}

	public int getFailedAttempts() {
		return failedAttempts;
	}

	public void setFailedAttempts(int failedAttempts) {
		this.failedAttempts = failedAttempts;
	}

	public int getFailedAnswerAttempts() {
		return failedAnswerAttempts;
	}

	public void setFailedAnswerAttempts(int failedAnswerAttempts) {
		this.failedAnswerAttempts = failedAnswerAttempts;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("UserTO [id=").append(id).append(", uuid=").append(uuid)
				.append(", userName=").append(userName)
				.append(", userNameLowercase=").append(userNameLowercase)
				.append(", lastActivity=").append(lastActivity)
				.append(", password=").append(password)
				.append(", passwordFormat=").append(passwordFormat)
				.append(", passwordSalt=").append(passwordSalt)
				.append(", email=").append(email).append(", emailLowercase=")
				.append(emailLowercase).append(", passwordQuestion=")
				.append(passwordQuestion).append(", passwordAnswer=")
				.append(passwordAnswer).append(", isApproved=")
				.append(isApproved).append(", lastLogin=").append(lastLogin)
				.append(", lastPasswordChange=").append(lastPasswordChange)
				.append(", isLockedOut=").append(isLockedOut)
				.append(", lastLockedOut=").append(lastLockedOut)
				.append(", failedAttempts=").append(failedAttempts)
				.append(", failedAnswerAttempts=").append(failedAnswerAttempts)
				.append(", comment=").append(comment).append(", createdDate=")
				.append(createdDate).append("]");
		return builder.toString();
	}
	
}
